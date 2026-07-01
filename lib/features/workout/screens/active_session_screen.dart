import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/routine.dart';
import '../providers/queries.dart';
import '../providers/workout_builder.dart';
import '../widgets/block_section.dart';
import '../widgets/end_session_dialog.dart';

class ActiveSessionScreen extends ConsumerWidget {
  const ActiveSessionScreen({super.key, required this.routine});

  final Routine routine;

  Future<void> _terminate(BuildContext context, WidgetRef ref) async {
    final rpe = await showDialog<int>(
      context: context,
      builder: (_) => const EndSessionDialog(),
    );
    if (rpe == null) return;
    await ref.read(workoutBuilderProvider(routine).notifier).finalize(rpe);
    ref.invalidate(sessionsLast28dProvider);
    if (context.mounted) context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(workoutBuilderProvider(routine));
    return Scaffold(
      appBar: AppBar(
        title: Text(routine.name),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: _SessionChrono(startedAt: session.date),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          for (final block in session.blocks)
            BlockSection(routine: routine, block: block),
          const SizedBox(height: 80),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FilledButton.icon(
            icon: const Icon(Icons.stop_circle),
            label: const Text('Terminer la séance'),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
            ),
            onPressed: () => _terminate(context, ref),
          ),
        ),
      ),
    );
  }
}

class _SessionChrono extends StatefulWidget {
  const _SessionChrono({required this.startedAt});

  final DateTime startedAt;

  @override
  State<_SessionChrono> createState() => _SessionChronoState();
}

class _SessionChronoState extends State<_SessionChrono> {
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = DateTime.now().difference(widget.startedAt);
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return Text('$m:$s', style: Theme.of(context).textTheme.titleMedium);
  }
}
