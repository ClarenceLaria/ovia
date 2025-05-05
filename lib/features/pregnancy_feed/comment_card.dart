import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
    required this.onTap,
    required this.userName,
    required this.commentText,
    required this.profilePic,
    required this.postTitle,
    required this.likesCount,
    required this.date,
    required this.commentsCount,
  });

  final VoidCallback onTap;
  final String userName;
  final String commentText;
  final String profilePic;
  final String postTitle;
  final int likesCount;
  final String date;
  final int commentsCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(profilePic),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  onPressed: (){},
                ),            
              ],
            ),
            const SizedBox(height: 8),
            Text(
              postTitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              commentText,
              style: const TextStyle(color: Colors.black54, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle like button press
                      },
                      icon: Icon(
                        likesCount > 0 ? Icons.favorite : Icons.favorite_outline, 
                        color: likesCount > 0 ? Colors.red : Colors.black, 
                        size: 16
                        ),
                      ),
                    const SizedBox(width: 2),
                    Text(
                      likesCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle like button press
                      },
                      icon: const Icon(Icons.chat, color: Colors.black, size: 16),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      commentsCount.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}