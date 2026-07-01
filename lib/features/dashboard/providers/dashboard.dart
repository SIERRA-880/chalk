import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/ai/api_key_store.dart';
import '../../../core/ai/mistral_service.dart';
import '../../../core/ai/payload_builder.dart';
import '../../../core/db/db.dart';
import '../../../core/math/engines.dart';
import '../../workout/models/exercise_set.dart';
import '../../workout/models/user_config.dart';
import '../../workout/providers/queries.dart';

part 'dashboard.g.dart';

typedef AcwrPoint = ({DateTime date, double ratio});
typedef OneRmPoint = ({DateTime date, double oneRm});

@riverpod
Future<List<AcwrPoint>> acwrHistory(Ref ref) async {
  final sessions = await ref.watch(sessionsLast28dProvider.future);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  return List.generate(28, (i) {
    final day = today.subtract(Duration(days: 27 - i));
    return (date: day, ratio: acwr(sessions, day));
  });
}

@riverpod
Future<List<OneRmPoint>> oneRmHistory(Ref ref, String exerciseId) async {
  if (exerciseId.isEmpty) return const [];
  final rows =
      await Db.instance.setHistoryWithDatesForExercise(exerciseId);
  final byDay = <DateTime, double>{};
  for (final r in rows) {
    final d = DateTime(r.date.year, r.date.month, r.date.day);
    final e = epley1RM(r.weight, r.reps);
    final cur = byDay[d];
    if (cur == null || e > cur) byDay[d] = e;
  }
  final entries = byDay.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));
  return [for (final e in entries) (date: e.key, oneRm: e.value)];
}

@Riverpod(keepAlive: true)
Future<Map<String, dynamic>> aiAdvice(Ref ref) async {
  // Capture les futures avant tout await pour éviter l'utilisation de ref
  // après une éventuelle disposal (autoDispose + 0 listeners).
  final exosFuture = ref.read(allExercisesProvider.future);
  final sessionsFuture = ref.read(sessionsLast28dProvider.future);

  final key = await ApiKeyStore().read();
  if (key == null || key.isEmpty) throw const _NoApiKey();
  final cfg = (await Db.instance.getUserConfig()) ??
      const UserConfig(id: 'default');
  final exos = await exosFuture;
  final sessions = await sessionsFuture;
  final setsByExo = <String, List<ExerciseSet>>{};
  for (final e in exos) {
    setsByExo[e.id] = await Db.instance.setsForExercise(e.id);
  }
  final payload = AIPayloadBuilder().build(
    userConfig: cfg,
    routines: exos,
    last14d: sessions,
    setsByExercise: setsByExo,
    now: DateTime.now(),
  );
  return MistralAgentService(apiKey: key).getAdvice(payload);
}

class _NoApiKey implements Exception {
  const _NoApiKey();
  @override
  String toString() => 'Configure d\'abord ta clé API Mistral.';
}
