import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/db.dart';
import '../../workout/models/exercise.dart';
import '../../workout/providers/queries.dart';

class CreateMenuScreen extends ConsumerWidget {
  const CreateMenuScreen({super.key});

  Future<void> _deleteExercise(
      BuildContext context, WidgetRef ref, Exercise e) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer l\'exercice'),
        content: Text('Supprimer « ${e.name} » ?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Annuler')),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await Db.instance.deleteExercise(e.id);
    ref.invalidate(allExercisesProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exosAsync = ref.watch(allExercisesProvider);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        FilledButton.icon(
          onPressed: () => context.push('/create/exercise'),
          icon: const Icon(Icons.fitness_center),
          label: const Text('Nouvel exercice'),
          style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56)),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () => context.push('/create/routine'),
          icon: const Icon(Icons.playlist_add),
          label: const Text('Nouvelle routine'),
          style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56)),
        ),
        const SizedBox(height: 24),
        Text('Exercices',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        exosAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Erreur : $e'),
          data: (exos) => exos.isEmpty
              ? const Text('Aucun exercice créé.')
              : Column(
                  children: [
                    for (final e in exos)
                      ListTile(
                        title: Text(e.name),
                        subtitle: Text(_trackingLabel(e)),
                        contentPadding: EdgeInsets.zero,
                        trailing: PopupMenuButton<_Action>(
                          itemBuilder: (_) => const [
                            PopupMenuItem(
                                value: _Action.edit,
                                child: Text('Modifier')),
                            PopupMenuItem(
                                value: _Action.delete,
                                child: Text('Supprimer')),
                          ],
                          onSelected: (action) {
                            if (action == _Action.edit) {
                              context.push('/create/exercise', extra: e);
                            } else {
                              _deleteExercise(context, ref, e);
                            }
                          },
                        ),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}

enum _Action { edit, delete }

String _trackingLabel(Exercise e) => switch (e.trackingType) {
      _ when e.isUnilateral => '${_typeLabel(e)} · unilatéral',
      _ => _typeLabel(e),
    };

String _typeLabel(Exercise e) => switch (e.trackingType) {
      final t => switch (t.name) {
          'weightAndReps' => 'Poids + Reps',
          'bodyweight' => 'Poids du corps',
          'timeBased' => 'Durée',
          _ => t.name,
        }
    };
