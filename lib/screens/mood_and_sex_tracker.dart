import 'package:flutter/material.dart';

class MoodAndSexTracker extends StatefulWidget {
  const MoodAndSexTracker({super.key});

  @override
  State<MoodAndSexTracker> createState() => _MoodAndSexTrackerState();
}

class _MoodAndSexTrackerState extends State<MoodAndSexTracker> {
  final Set<String> selectedSexOptions = {};
  final Set<String> selectedMoods = {};

  final List<Map<String, dynamic>> sexOptions = [
    {"text": "Didn't have sex", "color": Colors.redAccent},
    {"text": "Protected sex", "color": Colors.amber},
    {"text": "Unprotected sex", "color": Colors.deepOrange},
    {"text": "High sex drive", "color": Colors.green},
    {"text": "Low sex drive", "color": Colors.pinkAccent},
    {"text": "Masturbations", "color": Colors.deepPurple},
  ];

  final List<String> moodOptions = [
    "😊 Calm",
    "😊 Happy",
    "😊 Energetic",
    "😊 Frisky",
    "😊 Mood swings",
    "😊 Irritated",
    "😊 Sad",
    "😊 Anxious",
    "😊 Depressed",
    "😊 Feeling guilty",
    "😊 Confused",
    "😊 Lonely",
    "😊 Overwhelmed",
    "😊 Stressed",
  ];

  void _onApply() {
    // You can send this data to backend or show it in another screen
    print('Selected Sex Options: $selectedSexOptions');
    print('Selected Moods: $selectedMoods');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selections applied!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
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
                  Color(0xFFF0B3F3),
                  Color(0xFFF7D7C8),
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Edit', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _sectionTitle('Sex and sex drive'),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: sexOptions.map((option) {
                        final isSelected =
                            selectedSexOptions.contains(option["text"]);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedSexOptions.remove(option["text"]);
                              } else {
                                selectedSexOptions.add(option["text"]);
                              }
                            });
                          },
                          child: _IconChip(
                            text: option["text"],
                            color: option["color"],
                            selected: isSelected,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: _sectionTitle('Mood'),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: moodOptions.map((mood) {
                                final isSelected = selectedMoods.contains(mood);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        selectedMoods.remove(mood);
                                      } else {
                                        selectedMoods.add(mood);
                                      }
                                    });
                                  },
                                  child: _MoodChip(
                                    text: mood,
                                    selected: isSelected,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
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
                  onPressed: _onApply,
                  child: const Text('Apply',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }
}

class _IconChip extends StatelessWidget {
  final String text;
  final Color color;
  final bool selected;

  const _IconChip({
    required this.text,
    required this.color,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: selected ? color.withOpacity(0.2) : Colors.white,
        border: Border.all(
          color: selected ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                text,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor: color,
                radius: 14,
                child: Icon(
                  selected ? Icons.check : Icons.favorite_outline,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
