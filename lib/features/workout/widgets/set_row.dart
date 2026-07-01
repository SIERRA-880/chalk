import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/math/engines.dart';
import '../models/enums.dart';
import '../models/exercise_set.dart';
import '../models/routine.dart';
import '../providers/queries.dart';
import '../providers/workout_builder.dart';

class SetRow extends ConsumerWidget {
  const SetRow({
    super.key,
    required this.routine,
    required this.set,
    required this.index,
    required this.totalSets,
    required this.trackingType,
    required this.isUnilateral,
  });

  final Routine routine;
  final ExerciseSet set;
  final int index;
  final int totalSets;
  final TrackingType trackingType;
  final bool isUnilateral;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builder = ref.read(workoutBuilderProvider(routine).notifier);
    final showWeight = trackingType == TrackingType.weightAndReps;
    final isTimeBased = trackingType == TrackingType.timeBased;
    final isCalories = trackingType == TrackingType.calories;

    final suggestion = showWeight
        ? ref.watch(suggestedWeightProvider(set.exerciseId, set.reps ?? 8))
        : const AsyncData<double>(0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              set.side != null
                  ? '${index ~/ 2 + 1}${set.side}'
                  : '${index + 1}.',
              style: set.side != null
                  ? TextStyle(
                      fontWeight: FontWeight.bold,
                      color: set.side == 'G'
                          ? Colors.lightBlue
                          : Colors.orange,
                    )
                  : null,
            ),
          ),
          if (showWeight) ...[
            Expanded(
              child: TextFormField(
                initialValue: set.weight?.toString() ?? '',
                enabled: !set.completed,
                decoration: InputDecoration(
                  labelText: 'Poids',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: suggestion.maybeWhen(
                    data: (v) {
                      if (v == 0) return null;
                      final pairIndex =
                          isUnilateral ? index ~/ 2 : index;
                      final pairTotal =
                          isUnilateral ? totalSets ~/ 2 : totalSets;
                      final adjusted =
                          (v * pyramidFactor(pairIndex, pairTotal) / 2.5)
                                  .floorToDouble() *
                              2.5;
                      return adjusted.toStringAsFixed(1);
                    },
                    orElse: () => null,
                  ),
                  isDense: true,
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                ],
                onChanged: (v) => builder.updateSet(set.id,
                    weight: double.tryParse(v.replaceAll(',', '.'))),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: TextFormField(
              initialValue: isTimeBased
                  ? (set.durationSeconds?.toString() ?? '')
                  : (set.reps?.toString() ?? ''),
              enabled: !set.completed,
              decoration: InputDecoration(
                labelText: isTimeBased
                    ? 'Durée (s)'
                    : isCalories
                        ? 'Calories'
                        : 'Reps',
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (v) => isTimeBased
                  ? builder.updateSet(set.id,
                      durationSeconds: int.tryParse(v))
                  : builder.updateSet(set.id, reps: int.tryParse(v)),
            ),
          ),
          Checkbox(
            value: set.completed,
            onChanged: (v) =>
                builder.updateSet(set.id, completed: v ?? false),
          ),
        ],
      ),
    );
  }
}
