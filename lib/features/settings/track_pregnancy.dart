import 'package:flutter/material.dart';
import 'package:ovia_app/features/settings/app_lock_screen.dart';
import 'package:ovia_app/features/settings/card_section.dart';
import 'package:ovia_app/features/settings/graphs_reports_screen.dart';
import 'package:ovia_app/features/settings/restore_data_screen.dart';
import 'package:ovia_app/screens/settings/export_data_screen.dart';
import 'package:ovia_app/screens/settings/pregnancy_details_screen.dart';
import 'package:ovia_app/screens/settings/pregnancy_setup_screen.dart';

class TrackPregnancy extends StatelessWidget {
  const TrackPregnancy({super.key});

  static const List<Map<String, dynamic>> tileData1 = [
    {'icon': Icons.pregnant_woman, 'title': 'Pregnancy info setup', 'route': PregnancySetupScreen()},
    {'icon': Icons.lightbulb_circle_outlined, 'title': 'Pregnancy settings', 'route': PregnancyDetailsPage()},
    {'icon': Icons.upload, 'title': 'Export data', 'route': ExportDataScreen()},
    {'icon': Icons.settings_backup_restore, 'title': 'Restore data', 'route': RestoreDataScreen()},
  ];

  static const List<Map<String, dynamic>> tileData2 = [
    {'icon': Icons.auto_graph, 'title': 'Graphs & reports', 'route': GraphsReportsScreen()},
    {'icon': Icons.lock, 'title': 'App lock', 'route': AppLockScreen()},
    {'icon': Icons.notifications, 'title': 'Reminder'},
    {'icon': Icons.headphones, 'title': 'Support'},
  ];

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardSection(data: tileData1),
          SizedBox(height: 20),
          CardSection(data: tileData2),
        ],
      ),
    );
  }
}
