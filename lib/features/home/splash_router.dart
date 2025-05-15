import 'package:flutter/material.dart';
import 'package:ovia_app/screens/home_screen.dart';
import 'package:ovia_app/screens/user_info_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRouter extends StatelessWidget {
  const SplashRouter({super.key});

  Future<Widget> _determineStartPage() async {
    final prefs = await SharedPreferences.getInstance();
    final isSetupComplete = prefs.getBool('isSetupComplete') ?? false;

    if (isSetupComplete) {
      return const HomeScreen();
    } else {
      return const UserInfoSetupPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _determineStartPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
