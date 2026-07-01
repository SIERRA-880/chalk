import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exercise_active_timer.g.dart';

@riverpod
class ExerciseActiveTimer extends _$ExerciseActiveTimer {
  final Stopwatch _sw = Stopwatch();
  Timer? _ticker;

  @override
  Duration build(String exerciseId) {
    ref.onDispose(() {
      _ticker?.cancel();
      _sw.stop();
    });
    return Duration.zero;
  }

  void start() {
    if (_sw.isRunning) return;
    _sw.start();
    _ticker ??= Timer.periodic(
      const Duration(milliseconds: 200),
      (_) => state = _sw.elapsed,
    );
  }

  void stop() {
    _sw.stop();
    _ticker?.cancel();
    _ticker = null;
    state = _sw.elapsed;
  }

  void reset() {
    _sw.stop();
    _sw.reset();
    _ticker?.cancel();
    _ticker = null;
    state = Duration.zero;
  }
}
