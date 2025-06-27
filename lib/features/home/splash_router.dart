import 'package:flutter/material.dart';
import 'package:ovia_app/api_connectors/apis.dart';
import 'package:ovia_app/screens/entry_point.dart';
import 'package:ovia_app/screens/login_screen.dart';
import 'package:ovia_app/screens/user_info_setup.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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

  Widget _buildNoInternetPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Icon(Icons.wifi_off, size: 100, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No Internet Connection',
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Retry logic can be added here
                final connectivityResult = await Connectivity().checkConnectivity();
                if (connectivityResult != ConnectivityResult.none) {
                  // If internet is available, navigate to the start page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SplashRouter()),
                  );
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> _determineStartPage(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.none){
      return _buildNoInternetPage(context);
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
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _determineStartPage(context),
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
