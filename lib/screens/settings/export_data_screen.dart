import 'package:flutter/material.dart';

class ExportDataScreen extends StatefulWidget {
  const ExportDataScreen({super.key});

  @override
  State<ExportDataScreen> createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  bool _includeHealthStats = true;
  bool _includeSymptoms = true;
  bool _includeReminders = false;
  String _format = 'PDF';

  final List<String> _exportFormats = ['PDF', 'CSV', 'JSON'];

  void _exportData() {
    // Mock export logic
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Export Successful'),
        content: const Text('Your data has been exported and sent to your email.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export Data')),
      extendBody: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customize what you want to include in your export. The data will be sent to your registered email.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              activeColor: Theme.of(context).primaryColorLight,
              title: const Text('Include Health Statistics'),
              value: _includeHealthStats,
              onChanged: (val) => setState(() => _includeHealthStats = val),
            ),
            SwitchListTile(
              activeColor: Theme.of(context).primaryColorLight,
              title: const Text('Include Symptom Logs'),
              value: _includeSymptoms,
              onChanged: (val) => setState(() => _includeSymptoms = val),
            ),
            SwitchListTile(
              activeColor: Theme.of(context).primaryColorLight,
              title: const Text('Include Reminders and Notifications'),
              value: _includeReminders,
              onChanged: (val) => setState(() => _includeReminders = val),
            ),
            const SizedBox(height: 24),
            const Text('Select Export Format:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _format,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Change to Colors.black if preferred
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
              items: _exportFormats.map((format) => DropdownMenuItem(
                value: format,
                child: Text(format),
              )).toList(),
              onChanged: (val) => setState(() => _format = val ?? 'PDF'),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _exportData,
                icon: const Icon(Icons.upload_file),
                label: const Text('Export Data'),
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
