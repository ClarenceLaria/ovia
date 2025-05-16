import 'package:flutter/material.dart';
import 'package:ovia_app/api_connectors/login.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  Future<Map<String, dynamic>?> getUserProfile() async {
    final userProfile = await Auth().getUserProfile();
    return userProfile;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: getUserProfile(),
      builder: (context, snapshot) {
        String userName = 'Olivia';
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          userName = snapshot.data?['name'];
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Hello, ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage("assets/images/face.webp"),
              ),
            ],
          ),
        );
      },
    );
  }
}
