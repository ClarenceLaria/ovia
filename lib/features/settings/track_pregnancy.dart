import 'package:flutter/material.dart';

class TrackPregnancy extends StatelessWidget {
  const TrackPregnancy({super.key});

  static const List<Map<String, dynamic>> tileData1 = [
    {'icon': Icons.lock, 'title': 'Pregnancy settings'},
    {'icon': Icons.upload, 'title': 'Export data'},
    {'icon': Icons.settings_backup_restore, 'title': 'Restore data'},
  ];

  static const List<Map<String, dynamic>> tileData2 = [
    {'icon': Icons.auto_graph, 'title': 'Graphs & reports'},
    {'icon': Icons.lock, 'title': 'App lock'},
    {'icon': Icons.notifications, 'title': 'Reminder'},
    {'icon': Icons.headphones, 'title': 'Support'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardSection(tileData1),
          const SizedBox(height: 20),
          _buildCardSection(tileData2),
        ],
      ),
    );
  }

  Widget _buildCardSection(List<Map<String, dynamic>> data) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(data.length, (index) {
          final item = data[index];
          final isLast = index == data.length - 1;
          return _buildListTile(item['icon'], item['title'], isLast: isLast);
        }),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, {bool isLast = false}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black, size: 22),
          title: Text(title, style: const TextStyle(fontSize: 14)),
          trailing: const Icon(Icons.chevron_right_outlined, size: 20),
          horizontalTitleGap: 8,
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        if (!isLast)
          const Divider(height: 0.5, thickness: 0.5, indent: 16, endIndent: 16),
      ],
    );
  }
}
