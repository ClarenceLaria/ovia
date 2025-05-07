import 'package:flutter/material.dart';
import 'package:ovia_app/features/settings/card_section.dart';

class GetPregnant extends StatelessWidget {
  const GetPregnant({super.key});

  static const List<Map<String, dynamic>> tileData1 = [
    {'icon': Icons.favorite, 'title': 'Fertility settings'},
    {'icon': Icons.notifications, 'title': 'Ovulation reminders'},
    {'icon': Icons.show_chart, 'title': 'Fertility trends'},
  ];

  static const List<Map<String, dynamic>> tileData2 = [
    {'icon': Icons.upload, 'title': 'Export fertility data'},
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
          CardSection(data: tileData2),
        ],
      ),
    );
  }
}
