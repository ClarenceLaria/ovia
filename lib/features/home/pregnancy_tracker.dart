import 'package:flutter/material.dart';

class PregnancyTracker extends StatelessWidget {
  const PregnancyTracker({super.key});

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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LegendDot(color: Colors.pink, label: "Period phase"),
              SizedBox(width: 16),
              LegendDot(color: Colors.purple, label: "Fertile window"),
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
                  value: 0.6,
                  strokeWidth: 15,
                  backgroundColor: Colors.pink.shade100,
                  valueColor: const AlwaysStoppedAnimation(Colors.purple),
                ),
              ),
              Image.asset('assets/images/fetus.png', height: 220),
            ],
          ),
         Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink.shade300, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                child: const Text(
                  "Week 21",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
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
