import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ovia_app/screens/entry_point.dart';
import 'package:ovia_app/screens/login_screen.dart';
import 'package:ovia_app/screens/user_info_setup.dart';

class SplashRouter extends StatelessWidget {
  const SplashRouter({super.key});

  Future<Widget> _determineStartPage() async {
    //server side check
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const LoginScreen();
    }

    final doc = await FirebaseFirestore.instance
        .collection('userinfo')
        .doc(user.uid)
        .get();

    if (doc.exists &&
        doc.data() != null &&
        doc.data()!.containsKey('lastPeriodDate')) {
      return const EntryPoint();
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
