import 'package:flutter/material.dart';

class MoodAndSexTracker extends StatelessWidget {
  const MoodAndSexTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF0B3F3), // light purple-pink
              Color(0xFFF7D7C8), // light peach
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and search
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.black),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            icon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Categories title
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Edit',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Sex and sex drive
                _sectionTitle('Sex and sex drive'),
                const Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _IconChip(text: "Didn't have sex", color: Colors.redAccent),
                    _IconChip(text: "Protected sex", color: Colors.amber),
                    _IconChip(text: "Unprotected sex", color: Colors.deepOrange),
                    _IconChip(text: "High sex drive", color: Colors.green),
                    _IconChip(text: "Low sex drive", color: Colors.pinkAccent),
                    _IconChip(text: "Masturbations", color: Colors.deepPurple),
                  ],
                ),
                const SizedBox(height: 24),
                // Mood section
                _sectionTitle('Mood'),
                const Wrap(
                  spacing: 10,
                  runSpacing: 5,
                  children: [
                    _MoodChip(text: "😊 Calm"),
                    _MoodChip(text: "😊 Happy", selected: true),
                    _MoodChip(text: "😊 Energetic"),
                    _MoodChip(text: "😊 Frisky"),
                    _MoodChip(text: "😊 Mood swings"),
                    _MoodChip(text: "😊 Irritated"),
                    _MoodChip(text: "😊 sad"),
                    _MoodChip(text: "😊 Anxious"),
                    _MoodChip(text: "😊 Depressed"),
                    _MoodChip(text: "😊 Feeling guilty"),
                    _MoodChip(text: "😊 Confused"),
                  ],
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Apply',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }
}

// Reusable chip with icon and background color
class _IconChip extends StatelessWidget {
  final String text;
  final Color color;

  const _IconChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: color,
        radius: 10,
        child: const Icon(Icons.favorite, size: 12, color: Colors.white),
      ),
      backgroundColor: Colors.white,
      label: Text(text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

// Mood chip with optional selection styling
class _MoodChip extends StatelessWidget {
  final String text;
  final bool selected;

  const _MoodChip({required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: selected ? Colors.pink.shade50 : Colors.white,
      side: selected
          ? const BorderSide(color: Colors.pinkAccent, width: 1.5)
          : BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
