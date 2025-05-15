import 'package:flutter/material.dart';
import 'package:ovia_app/api_connectors/login.dart';
import 'package:ovia_app/features/home/splash_router.dart';
import 'package:ovia_app/screens/login_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const SplashRouter();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}