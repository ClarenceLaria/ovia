import 'package:flutter/material.dart';
import 'package:ovia_app/features/pregnancy_feed/feeds_card.dart';

class SavedFeed extends StatefulWidget {
  const SavedFeed({super.key});

  @override
  State<SavedFeed> createState() => _SavedFeedState();
}

class _SavedFeedState extends State<SavedFeed> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FeedsCard(
          likes: 1200, 
          comments: 812, 
          userName: 'Moms-To-Be-Club', 
          userImage: 'assets/images/face.webp', 
          postImage: 'assets/images/onboarding/pregnant1.png',
          postText: "Pregnancy is a beautiful journey, and every moment is worth cherishing. Let's celebrate the joy of motherhood together!",
          isSaved: true, 
          isFollowing: false,
        ),
        FeedsCard(
          likes: 1200, 
          comments: 812, 
          userName: 'Moms-To-Be-Club', 
          userImage: 'assets/images/face.webp', 
          postImage: 'assets/images/onboarding/pregnant1.png',
          postText: "Pregnancy is a beautiful journey, and every moment is worth cherishing. Let's celebrate the joy of motherhood together!",
          isSaved: true, 
          isFollowing: false,
        ),
        FeedsCard(
          likes: 1200, 
          comments: 812, 
          userName: 'Moms-To-Be-Club', 
          userImage: 'assets/images/face.webp', 
          postImage: 'assets/images/onboarding/pregnant1.png',
          postText: "Pregnancy is a beautiful journey, and every moment is worth cherishing. Let's celebrate the joy of motherhood together!",
          isSaved: true, 
          isFollowing: true,
        ),
      ],
    );
  }
}