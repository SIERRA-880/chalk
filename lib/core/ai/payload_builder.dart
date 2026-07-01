import '../../features/workout/models/exercise.dart';
import '../../features/workout/models/exercise_set.dart';
import '../../features/workout/models/user_config.dart';
import '../../features/workout/models/workout_session.dart';
import '../math/engines.dart';

class AIPayloadBuilder {
  Map<String, dynamic> build({
    required UserConfig userConfig,
    required List<Exercise> routines,
    required List<WorkoutSession> last14d,
    required Map<String, List<ExerciseSet>> setsByExercise,
    required DateTime now,
  }) {
    double load(WorkoutSession s) =>
        (s.sessionRPE * s.durationMinutes).toDouble();
    final acute = last14d
        .where((s) {
          final d = now.difference(s.date).inDays;
          return d >= 0 && d < 7;
        })
        .fold<double>(0, (a, s) => a + load(s));
    final chronic = last14d
            .where((s) {
              final d = now.difference(s.date).inDays;
              return d >= 0 && d < 28;
            })
            .fold<double>(0, (a, s) => a + load(s)) /
        4.0;

    return {
      'user_config': userConfig.toJson(),
      'routines': routines.map((e) => e.toJson()).toList(),
      'acwr_stats': {
        'acute': acute,
        'chronic': chronic,
        'ratio': acwr(last14d, now),
      },
      'records_1rm': {
        for (final e in routines)
          e.id: historical1RM(setsByExercise[e.id] ?? const []),
      },
      'history_14_days': last14d.map((s) => {
            'id': s.id,
            'date': s.date.toIso8601String(),
            'rpe': s.sessionRPE,
            'duration_minutes': s.durationMinutes,
          }).toList(),
    };
  }
}
