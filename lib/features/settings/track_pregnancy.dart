import 'package:flutter/material.dart';

class TrackPregnancy extends StatelessWidget {
  const TrackPregnancy({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardSection([
            _buildListTile(Icons.lightbulb_circle_outlined, 'Pregnancy settings'),
            _buildListTile(Icons.upload, 'Export data'),
            _buildListTile(Icons.settings_backup_restore, 'Restore data'),
          ]),
          const SizedBox(height: 20),
          _buildCardSection([
            _buildListTile(Icons.auto_graph, 'Graphs & reports'),
            _buildListTile(Icons.lock, 'App lock'),
            _buildListTile(Icons.notifications, 'Reminder'),
            _buildListTile(Icons.headphones, 'Support'),
          ]),
        ],
      ),
    );
  }

  Widget _buildCardSection(List<Widget> items) {
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
        children: items,
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      trailing: const Icon(Icons.chevron_right_outlined, size: 20),
      horizontalTitleGap: 8,
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}
