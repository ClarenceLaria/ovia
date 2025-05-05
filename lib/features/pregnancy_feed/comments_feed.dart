import 'package:flutter/material.dart';
import 'package:ovia_app/features/pregnancy_feed/comment_card.dart';

class CommentsFeed extends StatefulWidget {
  const CommentsFeed({super.key});

  @override
  State<CommentsFeed> createState() => _CommentsFeedState();
}

class _CommentsFeedState extends State<CommentsFeed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommentCard(
          onTap: () {},
          userName: 'Moms-To-Be-Club',
          commentText: 'This is a comment',
          profilePic: 'assets/images/face.webp',
          postTitle: 'Trimester 1: What to Expect',
          likesCount: 10,
          date: '2 days ago',
          commentsCount: 5,
        ),
        CommentCard(
          onTap: () {},
          userName: 'Moms-To-Be-Club',
          commentText: 'This is a comment',
          profilePic: 'assets/images/face.webp',
          postTitle: 'Post Title',
          likesCount: 10,
          date: '2 days ago',
          commentsCount: 5,
        ),
        CommentCard(
          onTap: () {},
          userName: 'Moms-To-Be-Club',
          commentText: 'This is a comment',
          profilePic: 'assets/images/face.webp',
          postTitle: 'Post Title',
          likesCount: 10,
          date: '2 days ago',
          commentsCount: 5,
        )
      ],
    );
  }
}