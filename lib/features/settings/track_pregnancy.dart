import 'package:flutter/material.dart';

class TrackPregnancy extends StatelessWidget {
  const TrackPregnancy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_circle_outlined, color: Colors.black, size: 20,),
                        Text('Pregnancy settings', style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Icon(Icons.chevron_right_outlined, color: Colors.black, size: 20,),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.upload, color: Colors.black, size: 20,),
                        Text('Export data', style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Icon(Icons.chevron_right_outlined, color: Colors.black, size: 20,),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings_backup_restore, color: Colors.black, size: 20,),
                        Text('Restore data', style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Icon(Icons.chevron_right_outlined, color: Colors.black, size: 20,),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16)
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_graph, color: Colors.black, size: 20,),
                        Text('Graph & reports', style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Icon(Icons.chevron_right_outlined, color: Colors.black, size: 20,),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lock, color: Colors.black, size: 20,),
                        Text('App lock', style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Icon(Icons.chevron_right_outlined, color: Colors.black, size: 20,),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.notifications, color: Colors.black, size: 20,),
                        Text('Reminder', style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Icon(Icons.chevron_right_outlined, color: Colors.black, size: 20,),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.headphones, color: Colors.black, size: 20,),
                        Text('Support', style: TextStyle(fontSize: 14),)
                      ],
                    ),
                    Icon(Icons.chevron_right_outlined, color: Colors.black, size: 20,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}