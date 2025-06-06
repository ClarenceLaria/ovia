import 'package:flutter/material.dart';
import 'package:ovia_app/features/home/calendar.dart';
import 'package:ovia_app/features/home/header.dart';
import 'package:ovia_app/features/home/pregnancy_tracker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
          child: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/phone-bg.webp'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Column(
          children: [
            Header(),
            SizedBox(height: 10),
            CycleCalendar(),
            SizedBox(height: 10),
            PregnancyTracker(),
          ],
        ),
      ])),
    );
  }
}
