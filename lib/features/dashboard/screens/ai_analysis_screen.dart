import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/ai/api_key_store.dart';
import '../providers/dashboard.dart';

class AiAnalysisScreen extends ConsumerStatefulWidget {
  const AiAnalysisScreen({super.key});

  @override
  ConsumerState<AiAnalysisScreen> createState() => _AiAnalysisScreenState();
}

class _AiAnalysisScreenState extends ConsumerState<AiAnalysisScreen> {
  AsyncValue<Map<String, dynamic>>? _result;
  bool _hasKey = false;
  bool _checkingKey = true;

  @override
  void initState() {
    super.initState();
    _checkKey();
  }

  Future<void> _checkKey() async {
    final k = await ApiKeyStore().read();
    if (!mounted) return;
    setState(() {
      _hasKey = k != null && k.isNotEmpty;
      _checkingKey = false;
    });
  }

  Future<void> _analyze() async {
    setState(() => _result = const AsyncLoading());
    ref.invalidate(aiAdviceProvider);
    try {
      final data = await ref.read(aiAdviceProvider.future);
      if (mounted) setState(() => _result = AsyncData(data));
    } catch (e, st) {
      if (mounted) setState(() => _result = AsyncError(e, st));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Analyse IA (Mistral)')),
        body: _checkingKey
            ? const Center(child: CircularProgressIndicator())
            : !_hasKey
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: FilledButton.icon(
                        icon: const Icon(Icons.key),
                        label: const Text('Configurer la clé API'),
                        style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52)),
                        onPressed: () async {
                          await context.push('/dashboard/api-key');
                          await _checkKey();
                        },
                      ),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Row(children: [
                        Expanded(
                          child: FilledButton.icon(
                            icon: const Icon(Icons.psychology),
                            label: const Text('Lancer l\'analyse'),
                            onPressed:
                                _result is AsyncLoading ? null : _analyze,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.key),
                          tooltip: 'Changer la clé API',
                          onPressed: () async {
                            await context.push('/dashboard/api-key');
                            await _checkKey();
                          },
                        ),
                      ]),
                      const SizedBox(height: 16),
                      if (_result != null) _buildResult(),
                    ],
                  ),
      );

  Widget _buildResult() => _result!.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Card(
          color: Theme.of(context).colorScheme.errorContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text('$e'),
          ),
        ),
        data: (result) => Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: MarkdownBody(
              data: (result['summary'] as String?) ??
                  'Réponse vide : ${result.toString()}',
            ),
          ),
        ),
      );
}
