import 'package:flutter/material.dart';

class StopSharingDialog extends StatefulWidget {
  const StopSharingDialog({super.key});

  @override
  State<StopSharingDialog> createState() => _StopSharingDialogDialogState();
}

class _StopSharingDialogDialogState extends State<StopSharingDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Stop sharing?'),
      content: const Text(
        'Are you sure you want to stop sharing this playlist?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Stop Sharing'),
        ),
      ],
    );
  }
}
