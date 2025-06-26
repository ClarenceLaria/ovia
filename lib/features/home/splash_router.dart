import 'package:flutter/material.dart';
import 'package:ovia_app/api_connectors/apis.dart';
import 'package:ovia_app/screens/entry_point.dart';
import 'package:ovia_app/screens/login_screen.dart';
import 'package:ovia_app/screens/user_info_setup.dart';

class SplashRouter extends StatelessWidget {
  const SplashRouter({super.key});

  // Future<Widget> _determineStartPage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isSetupComplete = prefs.getBool('isSetupComplete') ?? false;

  //   if (isSetupComplete) {
  //     return const EntryPoint();
  //   } else {
  //     return const UserInfoSetupPage();
  //   }
  // }

  Future<Widget> _determineStartPage() async {
  try {
    final result = await APIs().fetchUserInfo();

    print("Result from fetchUserInfo: $result");
    if (result != null && result['lastPeriodDate'] != null) {
      return const EntryPoint();
    } else {
      return const UserInfoSetupPage();
    }
  } catch (e) {
    print("Error in SplashRouter: $e");
    return const LoginScreen(); 
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
        }
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
