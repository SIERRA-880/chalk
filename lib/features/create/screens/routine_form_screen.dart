import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/db/db.dart';
import '../../workout/models/enums.dart';
import '../../workout/models/exercise.dart';
import '../../workout/models/routine.dart';
import '../../workout/providers/queries.dart';

class RoutineFormScreen extends ConsumerStatefulWidget {
  const RoutineFormScreen({super.key, this.routine});

  final Routine? routine;

  @override
  ConsumerState<RoutineFormScreen> createState() => _RoutineFormScreenState();
}

class _RoutineFormScreenState extends ConsumerState<RoutineFormScreen> {
  late final _name =
      TextEditingController(text: widget.routine?.name ?? '');
  late final _exercisesByBlock = <BlockType, List<RoutineExerciseRef>>{
    for (final t in BlockType.values)
      t: widget.routine?.blocks
              .firstWhere((b) => b.type == t,
                  orElse: () => RoutineBlock(type: t))
              .exercises
              .toList() ??
          [],
  };
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _addExercise(BlockType type) async {
    final exos = await ref.read(allExercisesProvider.future);
    if (!mounted) return;
    if (exos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Crée d\'abord un exercice.')));
      return;
    }
    final ref0 = await showDialog<RoutineExerciseRef>(
      context: context,
      builder: (_) => _AddExerciseDialog(exercises: exos),
    );
    if (ref0 == null) return;
    setState(() => _exercisesByBlock[type]!.add(ref0));
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Donne un nom à la routine.')));
      return;
    }
    setState(() => _saving = true);
    final routine = Routine(
      id: widget.routine?.id ?? const Uuid().v4(),
      name: _name.text.trim(),
      blocks: BlockType.values
          .map((t) =>
              RoutineBlock(type: t, exercises: _exercisesByBlock[t]!))
          .toList(),
    );
    await Db.instance.insertRoutine(routine);
    ref.invalidate(allRoutinesProvider);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final exosAsync = ref.watch(allExercisesProvider);
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.routine == null
              ? 'Nouvelle routine'
              : 'Modifier la routine')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Nom'),
          ),
          const SizedBox(height: 16),
          for (final type in BlockType.values)
            ExpansionTile(
              initiallyExpanded: true,
              title: Text(_blockLabel(type)),
              children: [
                ..._exercisesByBlock[type]!.map((r) => ListTile(
                      title: Text(_exerciseName(exosAsync, r.exerciseId)),
                      subtitle: Text(
                          '${r.targetSets} séries × ${r.targetReps} ${_exerciseUnit(exosAsync, r.exerciseId)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => setState(
                            () => _exercisesByBlock[type]!.remove(r)),
                      ),
                    )),
                TextButton.icon(
                  onPressed: () => _addExercise(type),
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter un exercice'),
                ),
              ],
            ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _save,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
            child: _saving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  String _exerciseName(AsyncValue<List<Exercise>> async, String id) =>
      async.maybeWhen(
        data: (xs) => xs.firstWhere(
          (e) => e.id == id,
          orElse: () => const Exercise(id: '', name: '?'),
        ).name,
        orElse: () => '…',
      );

  String _exerciseUnit(AsyncValue<List<Exercise>> async, String id) =>
      async.maybeWhen(
        data: (xs) {
          final ex = xs.firstWhere((e) => e.id == id,
              orElse: () => const Exercise(id: '', name: '?'));
          return ex.trackingType == TrackingType.timeBased ? 's' : 'reps';
        },
        orElse: () => 'reps',
      );
}

String _blockLabel(BlockType t) => switch (t) {
      BlockType.warmup => 'ÉCHAUFFEMENT',
      BlockType.main => 'CORPS DE SÉANCE',
      BlockType.finisher => 'FINISHER CARDIO',
    };

class _AddExerciseDialog extends StatefulWidget {
  const _AddExerciseDialog({required this.exercises});

  final List<Exercise> exercises;

  @override
  State<_AddExerciseDialog> createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<_AddExerciseDialog> {
  late Exercise _exercise = widget.exercises.first;
  int _sets = 3;
  int _reps = 8;

  bool get _isTimeBased => _exercise.trackingType == TrackingType.timeBased;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Ajouter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<Exercise>(
              initialValue: _exercise,
              isExpanded: true,
              items: widget.exercises
                  .map((e) =>
                      DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
              onChanged: (v) => setState(() {
                _exercise = v!;
                _reps = _isTimeBased ? 30 : 8;
              }),
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: TextFormField(
                  initialValue: '$_sets',
                  decoration: const InputDecoration(labelText: 'Séries'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => _sets = int.tryParse(v) ?? _sets,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  key: ValueKey(_exercise.id),
                  initialValue: '$_reps',
                  decoration: InputDecoration(
                      labelText: _isTimeBased ? 'Durée (s)' : 'Reps'),
                  keyboardType: TextInputType.number,
                  onChanged: (v) => _reps = int.tryParse(v) ?? _reps,
                ),
              ),
            ]),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler')),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(RoutineExerciseRef(
              exerciseId: _exercise.id,
              targetSets: _sets,
              targetReps: _reps,
            )),
            child: const Text('Ajouter'),
          ),
        ],
      );
}
