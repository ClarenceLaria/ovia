import 'package:flutter/material.dart';
import 'package:ovia_app/api_connectors/login.dart';
import 'package:ovia_app/screens/settings/settings_screen.dart';

class PregnancyHomeScreen extends StatelessWidget {
  const PregnancyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFFDEFF3),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _HeaderSection()),

            // Sticky search bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickySearchBarDelegate(),
            ),

            // Content
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SectionTitle('Most popular in pregnancy'),
                    const SizedBox(height: 12),
                    _ImageCardRow(cards: [
                      _ImageCardData(
                        label: "Let's talk about the rainbow babies",
                        color: Colors.lightBlue.shade100,
                        image: 'assets/images/baby.png',
                      ),
                      _ImageCardData(
                        label: "Your changing body: Up to 42 weeks",
                        color: Colors.pink.shade100,
                        image: 'assets/images/fetus.png',
                      ),
                    ]),
                    const SizedBox(height: 12),
                    const _SectionTitle('Pregnancy sex and pleasure'),
                    const SizedBox(height: 12),
                    _ImageCardRow(cards: [
                      _ImageCardData(
                        label: "8 bump-friendly sex positions",
                        color: Colors.purple.shade100,
                        image: 'assets/images/onboarding/pregnant1.webp',
                      ),
                      _ImageCardData(
                        label: "Your pregnancy sex need to know",
                        color: Colors.orange.shade100,
                        image: 'assets/images/onboarding/cramps1.webp',
                      ),
                    ]),
                    const SizedBox(height: 12),
                    const _SectionTitle('Pregnancy sex and pleasure'),
                    const SizedBox(height: 12),
                    _ImageCardRow(cards: [
                      _ImageCardData(
                        label: "8 bump-friendly sex positions",
                        color: Colors.purple.shade100,
                        image: 'assets/images/onboarding/pregnant1.webp',
                      ),
                      _ImageCardData(
                        label: "Your pregnancy sex need to know",
                        color: Colors.orange.shade100,
                        image: 'assets/images/onboarding/cramps1.webp',
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickySearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      // color: const Color.fromARGB(255, 245, 245, 245),
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: const Color.fromARGB(255, 245, 245, 245),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  double get minExtent => 70;

  @override
  double get maxExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _HeaderSection extends StatelessWidget {
  Future<Map<String, dynamic>?> getUserProfile() async {
    final userProfile = await Auth().getUserProfile();
    return userProfile;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: getUserProfile(),
      builder: (context, snapshot) {
        String userName = '';
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          userName = snapshot.data?['name'];
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                // backgroundImage: AssetImage('assets/images/face.webp'),
                radius: 20,
                backgroundColor: Colors.black87,
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.notifications_none), onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ));
                  }),
            ],
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
    );
  }
}

class _ImageCardData {
  final String label;
  final Color color;
  final String image;

  _ImageCardData(
      {required this.label, required this.color, required this.image});
}

class _ImageCardRow extends StatelessWidget {
  final List<_ImageCardData> cards;

  const _ImageCardRow({required this.cards});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cards
            .map(
              (card) => Container(
                height: 150,
                width: 150,
                // color: card.color,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        card.image,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      card.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
