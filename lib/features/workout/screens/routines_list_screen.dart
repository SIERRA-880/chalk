import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/db.dart';
import '../models/routine.dart';
import '../providers/queries.dart';

class RoutinesListScreen extends ConsumerWidget {
  const RoutinesListScreen({super.key});

  Future<void> _delete(BuildContext context, WidgetRef ref, Routine r) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer la routine'),
        content: Text('Supprimer « ${r.name} » ?'),
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
    await Db.instance.deleteRoutine(r.id);
    ref.invalidate(allRoutinesProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routinesAsync = ref.watch(allRoutinesProvider);
    return Scaffold(
      body: routinesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (routines) => routines.isEmpty
            ? const Center(child: Text('Aucune routine. Crée-en une.'))
            : ListView.separated(
                itemCount: routines.length,
                separatorBuilder: (_, _) => const Divider(height: 0),
                itemBuilder: (_, i) {
                  final r = routines[i];
                  final total = r.blocks.fold<int>(
                      0, (a, b) => a + b.exercises.length);
                  return ListTile(
                    title: Text(r.name),
                    subtitle: Text('$total exercices'),
                    onTap: () =>
                        context.push('/workout/active', extra: r),
                    trailing: PopupMenuButton<_Action>(
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                            value: _Action.edit, child: Text('Modifier')),
                        PopupMenuItem(
                            value: _Action.delete, child: Text('Supprimer')),
                      ],
                      onSelected: (action) {
                        if (action == _Action.edit) {
                          context.push('/workout/edit-routine', extra: r);
                        } else {
                          _delete(context, ref, r);
                        }
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'history',
            onPressed: () => context.push('/workout/history'),
            child: const Icon(Icons.history),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () => context.push('/create/routine'),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

enum _Action { edit, delete }
