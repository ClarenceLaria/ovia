import 'package:flutter/material.dart';
import 'package:ovia_app/api_connectors/apis.dart';
import 'package:ovia_app/screens/mood_and_sex_tracker.dart';

class PregnancyTracker extends StatefulWidget {
  const PregnancyTracker({super.key});

  @override
  State<PregnancyTracker> createState() => _PregnancyTrackerState();
}

class _PregnancyTrackerState extends State<PregnancyTracker> {
  final image = 'assets/images/baby.png';
  bool isPregnant = false;
  double progress = 0.0;
  int weeksPregnant = 0;

  Future<void> fetchPregnancyInfo() async {
    try {
      final result = await APIs().fetchPregnancyInfo();
      print(result);
      if (result != null) {
        if (!mounted) return;
        setState(() {
          progress = (result['percentageProgress'] as num?)?.toDouble() ?? 0.0;
          weeksPregnant = result['weeksPregnant'] as int? ?? 0;
        });
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error fetching pregnancy data'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Internal Server Error'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPregnancyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isPregnant) ...[
                const LegendDot(
                    color: Colors.purple, label: "Pregnancy Progress"),
              ] else ...[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LegendDot(color: Colors.red, label: "Menstrual Phase"),
                    SizedBox(width: 8),
                    LegendDot(
                        color: Colors.lightBlue, label: "Follicular Phase"),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LegendDot(color: Colors.purple, label: "Ovulation"),
                    SizedBox(width: 8),
                    LegendDot(color: Colors.orange, label: "Luteal Phase"),
                  ],
                )
              ]
            ],
          ),
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: progress / 100,
                  strokeWidth: 15,
                  backgroundColor: Colors.pink.shade100,
                  valueColor: const AlwaysStoppedAnimation(Colors.purple),
                ),
              ),
              Container(
                  width: isPregnant ? 150 : 200,
                  height: isPregnant ? 150 : 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    color: Colors.pink.shade100.withOpacity(0.25),
                  ),
                  padding: EdgeInsets.all(isPregnant ? 20 : 10),
                  child: Image.asset(
                      isPregnant
                          ? 'assets/images/baby.png'
                          : 'assets/images/menstrual-cycle.webp',
                      height: 80)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            isPregnant
                ? "Week $weeksPregnant of Pregnancy"
                : "Cycle Day 5: Ovulation Approaching",
            style: const TextStyle(fontSize: 14),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MoodAndSexTracker(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.pink.shade300, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              isPregnant ? 'week ${weeksPregnant.toString()}' : 'Day 5',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const LegendDot({required this.color, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: color),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
