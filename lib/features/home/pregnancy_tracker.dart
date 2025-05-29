import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ovia_app/api_connectors/apis.dart';
import 'package:ovia_app/screens/mood_and_sex_tracker.dart';

class PregnancyTracker extends StatefulWidget {
  const PregnancyTracker({super.key});

  @override
  State<PregnancyTracker> createState() => _PregnancyTrackerState();
}

class _PregnancyTrackerState extends State<PregnancyTracker> {
  // Variables for pregnancy tracking
  bool isLoading = true;
  bool isPregnant = false;
  double progress = 0.0;
  int weeksPregnant = 0;

  //Variables for menstrual cycle tracking
  int currentDay = 0;
  int totalDays = 0;
  String currentPhase = '';
  double get menstrualCycleProgress {
    if (totalDays <= 0) return 0.0;
    return currentDay / totalDays;
  }

  String? getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  // FETCH for menstrual cycle phases
  void getCycleData() async {
    isLoading = true;
    final userId = getCurrentUserId();
    final data = await APIs().fetchUserCycle(userId!);

    if (!mounted) return;

    if (data != null) {
      setState(() {
        currentDay = data['currentDay'] as int? ?? 0;
        currentPhase = data['currentPhase'] as String? ?? '';
        totalDays = data['cycleLength'] as int? ?? 28;
        isLoading = false;
      });
      print(
          "Current Day: $currentDay, Current Phase: $currentPhase, Total Days: $totalDays");
    } else {
      print("Failed to fetch user cycle.");
    }
  }

  // Pregnancy Data fetching
  Future<void> fetchPregnancyInfo() async {
    try {
      isLoading = true;
      final result = await APIs().fetchPregnancyInfo();
      print(result);
      if (result != null) {
        if (!mounted) return;
        setState(() {
          isPregnant = result['isPregnant'] == true;
          progress = (result['percentageProgress'] as num?)?.toDouble() ?? 0.0;
          weeksPregnant = result['weeksPregnant'] as int? ?? 0;
          isLoading = false;
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

  // Color by phase
  Color get phaseColor {
    switch (currentPhase) {
      case 'Menstrual Phase':
        return Colors.red;
      case 'Follicular Phase':
        return Colors.lightBlue;
      case 'Ovulation Phase':
        return Colors.purple;
      case 'Fertile Window':
        return Colors.purple;
      case 'Luteal Phase':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPregnancyInfo();
    getCycleData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else {
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
                  child: isPregnant
                      ? CircularProgressIndicator(
                          value: progress / 100,
                          strokeWidth: 15,
                          backgroundColor: Colors.pink.shade100,
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.purple),
                        )
                      : CircularProgressIndicator(
                          value: menstrualCycleProgress,
                          strokeWidth: 15,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(phaseColor),
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MoodAndSexTracker(),
                      ),
                    );
                  },
                  child: Container(
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
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              isPregnant
                  ? "Week $weeksPregnant of Pregnancy"
                  : "Cycle Day $currentDay: $currentPhase",
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
                isPregnant
                    ? 'week ${weeksPregnant.toString()}'
                    : 'Day $currentDay',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      );
    }
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
