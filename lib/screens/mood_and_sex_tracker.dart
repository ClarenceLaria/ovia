import 'package:flutter/material.dart';

class MoodAndSexTracker extends StatelessWidget {
  const MoodAndSexTracker({super.key});

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
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _StickySearchBarDelegate(),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 80), // Spacer to prevent content under FAB
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Floating Apply Button
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
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

// Sticky Search Bar Delegate
class _StickySearchBarDelegate extends SliverPersistentHeaderDelegate {
  final double _height = 70;

  @override
  double get minExtent => _height;
  @override
  double get maxExtent => _height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

// Custom Chips
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
