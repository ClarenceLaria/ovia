import 'package:flutter/material.dart';
import 'package:ovia_app/features/pregnancy_feed/following_feed.dart';
import 'package:ovia_app/features/pregnancy_feed/popular_feed.dart';
import 'package:ovia_app/features/pregnancy_feed/saved_feed.dart';

class PregnancyFeedScreen extends StatefulWidget {
  const PregnancyFeedScreen({super.key});

  @override
  State<PregnancyFeedScreen> createState() => _PregnancyFeedScreenState();
}

class _PregnancyFeedScreenState extends State<PregnancyFeedScreen> {

  int _selectedIndex = 0;
  final List<Widget> tabs = [
    const PopularFeeds(),
    const FollowingFeeds(),
    const SavedFeed(),
    const Center(child: Text('My comments')),
  ];
  final List<String> buttonTabs = [
    'Popular',
    'Following',
    'Saved',
    'My comments',
  ];

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/face.webp'),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top:8.0, bottom: 8.0),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.notifications_outlined, color: Colors.black, size: 20),
                            onPressed: (){},
                          ),
                        ),
                      ),
                      Positioned(
                        top: 1,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(3),
                          child: const Text(
                            '5+',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      buttonTabs.length, 
                      (index) => GestureDetector(
                        onTap: () => onTap(index),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: index == _selectedIndex ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 7),
                          child: Text(
                            buttonTabs[index], 
                            style: TextStyle(color: index == _selectedIndex ? Colors.white : Colors.black, fontSize: 13),
                          ),
                        ),
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              tabs[_selectedIndex],
            ],
          ),
        )
      ),
    );
  }
}