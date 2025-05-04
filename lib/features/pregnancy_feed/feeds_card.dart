import 'package:flutter/material.dart';

class FeedsCard extends StatelessWidget {
  const FeedsCard({
    super.key,
    required this.likes,
    required this.comments,
    required this.userName,
    required this.userImage,
    required this.postImage,
    required this.postText,
    required this.isSaved,
    required this.isFollowing,
  });

  final int likes;
  final int comments;
  final String userName;
  final String userImage;
  final String postImage;
  final String postText;
  final bool isSaved;
  final bool isFollowing;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 460,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(userImage),
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
                Container(
                  decoration: BoxDecoration(
                    color: isFollowing ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    isFollowing ? "Unfollow" : "Follow",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isFollowing ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  onPressed: (){},
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                postImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle like button press
                          },
                          icon: Icon(
                            likes > 0 ? Icons.favorite : Icons.favorite_outline, 
                            color: likes > 0 ? Colors.red : Colors.black, 
                            size: 16
                            ),
                          ),
                        const SizedBox(width: 2),
                        Text(
                          likes.toString(),
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
                          comments.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                IconButton(
                  onPressed: (){}, 
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border, 
                    color: Colors.black, 
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              postText,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}