import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../core/db/db.dart';
import '../../workout/models/user_config.dart';

class UserConfigScreen extends StatefulWidget {
  const UserConfigScreen({super.key});

  @override
  State<UserConfigScreen> createState() => _UserConfigScreenState();
}

class _UserConfigScreenState extends State<UserConfigScreen> {
  final _objectives = TextEditingController();
  final _weight = TextEditingController();
  final _age = TextEditingController();
  bool _loading = true;
  bool _saving = false;
  String _id = 'default';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final cfg = await Db.instance.getUserConfig();
    if (!mounted) return;
    if (cfg != null) {
      _id = cfg.id;
      _objectives.text = cfg.globalObjectives;
      _weight.text = cfg.bodyWeightKg?.toString() ?? '';
      _age.text = cfg.age?.toString() ?? '';
    }
    setState(() => _loading = false);
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await Db.instance.saveUserConfig(UserConfig(
        id: _id,
        globalObjectives: _objectives.text.trim(),
        bodyWeightKg: double.tryParse(_weight.text.replaceAll(',', '.')),
        age: int.tryParse(_age.text),
      ));
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void dispose() {
    _objectives.dispose();
    _weight.dispose();
    _age.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Mon profil')),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _weight,
                    decoration: const InputDecoration(
                      labelText: 'Poids de corps (kg)',
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d.,]')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _age,
                    decoration: const InputDecoration(labelText: 'Âge'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _objectives,
                    decoration: const InputDecoration(
                      labelText: 'Objectifs',
                      hintText: 'Ex : prise de masse, améliorer le squat…',
                    ),
                    minLines: 3,
                    maxLines: 6,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _saving ? null : _save,
                    style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48)),
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
