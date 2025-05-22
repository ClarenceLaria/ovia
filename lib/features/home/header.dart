import 'package:flutter/material.dart';
import 'package:ovia_app/api_connectors/login.dart';
import 'package:ovia_app/screens/settings/settings_screen.dart';

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
        String userName = '';
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ));
                },
                child: CircleAvatar(
                    radius: 18,
                    // backgroundImage: const AssetImage("assets/images/face.webp"),
                    backgroundColor: Colors.black87,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}
