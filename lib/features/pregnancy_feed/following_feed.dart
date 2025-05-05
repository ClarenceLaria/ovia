import 'package:flutter/material.dart';
import 'package:ovia_app/features/pregnancy_feed/feeds_card.dart';

class FollowingFeeds extends StatefulWidget {
  const FollowingFeeds({super.key});

  @override
  State<FollowingFeeds> createState() => _FollowingFeedsState();
}

class _FollowingFeedsState extends State<FollowingFeeds> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FeedsCard(
          likes: 1200, 
          comments: 812, 
          userName: 'Moms-To-Be-Club', 
          userImage: 'assets/images/face.webp', 
          postImage: 'assets/images/onboarding/pregnant1.webp',
          postText: "Pregnancy is a beautiful journey, and every moment is worth cherishing. Let's celebrate the joy of motherhood together!",
          isSaved: false, 
          isFollowing: true,
        ),
        FeedsCard(
          likes: 1200, 
          comments: 812, 
          userName: 'Moms-To-Be-Club', 
          userImage: 'assets/images/face.webp', 
          postImage: 'assets/images/onboarding/pregnant1.webp',
          postText: "Pregnancy is a beautiful journey, and every moment is worth cherishing. Let's celebrate the joy of motherhood together!",
          isSaved: true, 
          isFollowing: true,
        ),
        FeedsCard(
          likes: 1200, 
          comments: 812, 
          userName: 'Moms-To-Be-Club', 
          userImage: 'assets/images/face.webp', 
          postImage: 'assets/images/onboarding/pregnant1.webp',
          postText: "Pregnancy is a beautiful journey, and every moment is worth cherishing. Let's celebrate the joy of motherhood together!",
          isSaved: false, 
          isFollowing: true,
        ),
      ],
    );
  }
}