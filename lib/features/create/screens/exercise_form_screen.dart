import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/db/db.dart';
import '../../workout/models/enums.dart';
import '../../workout/models/exercise.dart';
import '../../workout/providers/queries.dart';

class ExerciseFormScreen extends ConsumerStatefulWidget {
  const ExerciseFormScreen({super.key, this.exercise});

  final Exercise? exercise;

  @override
  ConsumerState<ExerciseFormScreen> createState() => _ExerciseFormScreenState();
}

class _ExerciseFormScreenState extends ConsumerState<ExerciseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.exercise?.name ?? '');
  late bool _isUnilateral = widget.exercise?.isUnilateral ?? false;
  late TrackingType _trackingType =
      widget.exercise?.trackingType ?? TrackingType.weightAndReps;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await Db.instance.upsertExercise(Exercise(
      id: widget.exercise?.id ?? const Uuid().v4(),
      name: _name.text.trim(),
      isUnilateral: _isUnilateral,
      trackingType: _trackingType,
    ));
    ref.invalidate(allExercisesProvider);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.exercise == null
              ? 'Nouvel exercice'
              : 'Modifier l\'exercice'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _name,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Requis' : null,
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                title: const Text('Unilatéral'),
                value: _isUnilateral,
                onChanged: (v) => setState(() => _isUnilateral = v ?? false),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<TrackingType>(
                initialValue: _trackingType,
                decoration: const InputDecoration(labelText: 'Tracking'),
                items: TrackingType.values
                    .map((t) => DropdownMenuItem(
                          value: t,
                          child: Text(_trackingLabel(t)),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _trackingType = v!),
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
        ),
      );
}

String _trackingLabel(TrackingType t) => switch (t) {
      TrackingType.weightAndReps => 'Poids + Reps',
      TrackingType.bodyweight => 'PDC + Reps',
      TrackingType.timeBased => 'Durée',
      TrackingType.calories => 'Calories',
    };
