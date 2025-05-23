import 'package:flutter/material.dart';
import 'package:ovia_app/features/settings/card_section.dart';

class TrackCycle extends StatelessWidget {
  const TrackCycle({super.key});

  static const List<Map<String, dynamic>> tileData1 = [
    {'icon': Icons.edit_calendar, 'title': 'Period settings'},
    {'icon': Icons.alarm_on, 'title': 'Cycle reminders'},
    {'icon': Icons.auto_graph, 'title': 'Cycle statistics'},
  ];

  static const List<Map<String, dynamic>> tileData2 = [
    {'icon': Icons.backup, 'title': 'Export cycle data'},
    {'icon': Icons.restore, 'title': 'Restore data'},
    {'icon': Icons.lock, 'title': 'App lock'},
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
          CardSection(data: tileData2),        ],
      ),
    );
  }
}
