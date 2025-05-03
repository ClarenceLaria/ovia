import 'package:flutter/material.dart';

class MoodAndSexTracker extends StatelessWidget {
  const MoodAndSexTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top:8.0, bottom: 8.0),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button and search
                    Container(
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
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle('Mood'),
          
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Wrap(
                              spacing: 5,
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
                                _MoodChip(text: "😊 Confused"),
                                _MoodChip(text: "😊 Confused"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30), // Bottom padding for scroll
                  ],
                ),
              ),
            ),
          ),
          // Apply button
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Apply',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
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
      label: Text(text, style: const TextStyle(fontSize: 12)),
      backgroundColor: selected ? Colors.pink.shade50 : Colors.white,
      side: selected
          ? const BorderSide(color: Colors.pinkAccent, width: 1.5)
          : BorderSide(color: Colors.grey.shade300, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
