import 'package:flutter/material.dart';

class RestoreDataScreen extends StatefulWidget {
  const RestoreDataScreen({super.key});

  @override
  State<RestoreDataScreen> createState() => _RestoreDataScreenState();
}

class _RestoreDataScreenState extends State<RestoreDataScreen> {
  bool _restoreHealthStats = true;
  bool _restoreSymptoms = true;
  bool _restoreReminders = false;
  String _backupSource = 'Cloud';

  final List<String> _backupSources = ['Cloud', 'Local Storage'];

  void _restoreData() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Restore Complete'),
        content: const Text('Your data has been successfully restored.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restore Data')),
      extendBody: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select the backup source and data categories you want to restore.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text('Choose Backup Source:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _backupSource,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
              items: _backupSources.map((source) => DropdownMenuItem(
                value: source,
                child: Text(source),
              )).toList(),
              onChanged: (val) => setState(() => _backupSource = val ?? 'Cloud'),
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              activeColor: Theme.of(context).primaryColorLight,
              title: const Text('Restore Health Statistics'),
              value: _restoreHealthStats,
              onChanged: (val) => setState(() => _restoreHealthStats = val),
            ),
            SwitchListTile(
              activeColor: Theme.of(context).primaryColorLight,
              title: const Text('Restore Symptom Logs'),
              value: _restoreSymptoms,
              onChanged: (val) => setState(() => _restoreSymptoms = val),
            ),
            SwitchListTile(
              activeColor: Theme.of(context).primaryColorLight,
              title: const Text('Restore Reminders'),
              value: _restoreReminders,
              onChanged: (val) => setState(() => _restoreReminders = val),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _restoreData,
                icon: const Icon(Icons.restore),
                label: const Text('Restore Now'),
                style: ElevatedButton.styleFrom(
                  // minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
