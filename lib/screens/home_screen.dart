import 'package:flutter/material.dart';
import 'package:ovia_app/features/home/calendar.dart';
import 'package:ovia_app/features/home/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            // GradientContainer(colors: [Color.fromARGB(255, 240, 179, 243), Color.fromARGB(255,247,215,200)], begin: Alignment.topLeft, end: Alignment.bottomRight, child: CycleCalendar())
            CycleCalendar(),
          ],
        )
      ),
    );
  }
}