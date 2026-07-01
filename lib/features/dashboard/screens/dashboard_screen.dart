import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../workout/providers/queries.dart';
import '../providers/dashboard.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String? _selectedExoId;

  @override
  Widget build(BuildContext context) {
    final acwrAsync = ref.watch(acwrHistoryProvider);
    final exosAsync = ref.watch(allExercisesProvider);
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _SectionTitle('ACWR (28 derniers jours)'),
        SizedBox(
          height: 220,
          child: acwrAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erreur : $e')),
            data: (points) => _AcwrChart(points: points),
          ),
        ),
        const SizedBox(height: 24),
        _SectionTitle('Évolution 1RM par exercice'),
        exosAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Erreur : $e'),
          data: (exos) {
            if (exos.isEmpty) return const Text('Crée d\'abord un exercice.');
            _selectedExoId ??= exos.first.id;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButton<String>(
                  value: _selectedExoId,
                  isExpanded: true,
                  items: exos
                      .map((e) =>
                          DropdownMenuItem(value: e.id, child: Text(e.name)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedExoId = v),
                ),
                SizedBox(
                  height: 220,
                  child: _OneRmChart(exerciseId: _selectedExoId!),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          icon: const Icon(Icons.psychology),
          label: const Text('Analyse IA (Mistral)'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          onPressed: () => context.push('/dashboard/ai-analysis'),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(text, style: Theme.of(context).textTheme.titleMedium),
      );
}

class _AcwrChart extends StatelessWidget {
  const _AcwrChart({required this.points});
  final List<AcwrPoint> points;

  @override
  Widget build(BuildContext context) {
    final maxY = [...points.map((p) => p.ratio), 1.5]
        .reduce((a, b) => a > b ? a : b);
    return LineChart(LineChartData(
      minY: 0,
      maxY: maxY + 0.2,
      titlesData: const FlTitlesData(
        leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 32)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      extraLinesData: ExtraLinesData(horizontalLines: [
        HorizontalLine(
          y: 1.5,
          color: Colors.red,
          strokeWidth: 1.5,
          dashArray: [6, 4],
        ),
      ]),
      lineBarsData: [
        LineChartBarData(
          spots: [
            for (var i = 0; i < points.length; i++)
              FlSpot(i.toDouble(), points[i].ratio),
          ],
          isCurved: false,
          dotData: const FlDotData(show: false),
          barWidth: 2,
        ),
      ],
    ));
  }
}

class _OneRmChart extends ConsumerWidget {
  const _OneRmChart({required this.exerciseId});
  final String exerciseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(oneRmHistoryProvider(exerciseId));
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur : $e')),
      data: (pts) {
        if (pts.isEmpty) {
          return const Center(child: Text('Pas encore de données.'));
        }
        return LineChart(LineChartData(
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 32)),
            bottomTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                for (var i = 0; i < pts.length; i++)
                  FlSpot(i.toDouble(), pts[i].oneRm),
              ],
              isCurved: false,
              dotData: const FlDotData(show: true),
              barWidth: 2,
            ),
          ],
        ));
      },
    );
  }
}
