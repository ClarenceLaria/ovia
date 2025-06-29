import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ovia_app/api_connectors/apis.dart';
import 'package:ovia_app/screens/entry_point.dart';
import 'package:ovia_app/screens/login_screen.dart';
import 'package:ovia_app/screens/user_info_setup.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ovia_app/screens/no_internet_screen.dart';

class SplashRouter extends StatefulWidget {
  const SplashRouter({super.key});

  @override
  State<SplashRouter> createState() => _SplashRouterState();
}

class _SplashRouterState extends State<SplashRouter> {
  late Future<Widget> _startPage;

  Future<bool> _hasRealInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<Widget> _determineStartPage() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    print("Connectivity result: $connectivityResult");
    if(connectivityResult.isEmpty || connectivityResult.contains(ConnectivityResult.none)) {
      return const NoInternetScreen();
    }

    bool hasInternet = await _hasRealInternetConnection();
    if (!hasInternet) {
      return const NoInternetScreen();
    }

    try {
      final result = await APIs().fetchUserInfo();

      print("Result from fetchUserInfo: $result");
      if (result != null) {
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
  void initState() {
    super.initState();
    _startPage = _determineStartPage();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _startPage,
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
