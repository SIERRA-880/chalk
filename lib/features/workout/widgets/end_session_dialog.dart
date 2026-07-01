import 'package:flutter/material.dart';

class EndSessionDialog extends StatefulWidget {
  const EndSessionDialog({super.key});

  @override
  State<EndSessionDialog> createState() => _EndSessionDialogState();
}

class _EndSessionDialogState extends State<EndSessionDialog> {
  double _rpe = 3;

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Terminer la séance'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('RPE global : ${_rpe.toInt()}'),
            Slider(
              value: _rpe,
              min: 1,
              max: 5,
              divisions: 4,
              label: '${_rpe.toInt()}',
              onChanged: (v) => setState(() => _rpe = v),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler')),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(_rpe.toInt()),
            child: const Text('Enregistrer'),
          ),
        ],
      );
}
