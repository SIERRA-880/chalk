import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/db.dart';
import '../models/workout_session.dart';
import '../providers/queries.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(allSessionsHistoryProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Historique')),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (sessions) {
          if (sessions.isEmpty) {
            return const Center(
                child: Text('Aucune séance enregistrée pour l\'instant.'));
          }
          final sorted = [...sessions]
            ..sort((a, b) => b.date.compareTo(a.date));
          return ListView.separated(
            itemCount: sorted.length,
            separatorBuilder: (_, _) => const Divider(height: 0),
            itemBuilder: (_, i) {
              final session = sorted[i];
              return Dismissible(
                key: ValueKey(session.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (_) => showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Supprimer la séance ?'),
                    content: const Text(
                        'Cette action est irréversible.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(false),
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(true),
                        child: const Text('Supprimer',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                ),
                onDismissed: (_) async {
                  await Db.instance.deleteSession(session.id);
                  ref.invalidate(allSessionsHistoryProvider);
                  ref.invalidate(sessionsLast28dProvider);
                },
                child: _SessionTile(session: session),
              );
            },
          );
        },
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session});
  final WorkoutSession session;

  @override
  Widget build(BuildContext context) {
    final totalSets = session.blocks
        .fold<int>(0, (acc, b) => acc + b.sets.length);
    return ListTile(
      title: Text(_formatDate(session.date)),
      subtitle: Text('${session.durationMinutes} min · $totalSets séries'),
      trailing: _RpeChip(rpe: session.sessionRPE),
      onTap: () => context.push('/workout/history/detail', extra: session),
    );
  }

  String _formatDate(DateTime d) {
    const jours = [
      'Lundi', 'Mardi', 'Mercredi', 'Jeudi',
      'Vendredi', 'Samedi', 'Dimanche'
    ];
    const mois = [
      'jan', 'fév', 'mar', 'avr', 'mai', 'juin',
      'juil', 'aoû', 'sep', 'oct', 'nov', 'déc'
    ];
    return '${jours[d.weekday - 1]} ${d.day} ${mois[d.month - 1]} ${d.year}';
  }
}

class _RpeChip extends StatelessWidget {
  const _RpeChip({required this.rpe});
  final int rpe;

  @override
  Widget build(BuildContext context) {
    final color = switch (rpe) {
      1 || 2 => Colors.green,
      3 => Colors.orange,
      _ => Colors.red,
    };
    return Chip(
      label: Text('RPE $rpe',
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      side: BorderSide(color: color),
      backgroundColor: color.withAlpha(30),
      padding: EdgeInsets.zero,
    );
  }
}
