import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class AppLockScreen extends StatefulWidget {
  const AppLockScreen({super.key});

  @override
  State<AppLockScreen> createState() => _AppLockScreenState();
}

class _AppLockScreenState extends State<AppLockScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  // bool _isBiometricSupported = false;
  // bool _isDeviceSupported = false;
  // List<BiometricType> _availableBiometrics = [];

  // Future<void> _initializeAuthSupport() async {
  //   _isBiometricSupported = await auth.canCheckBiometrics;
  //   _isDeviceSupported = await auth.isDeviceSupported();
  //   _availableBiometrics = await auth.getAvailableBiometrics();
  //   setState(() {});
  // }

  Future<void> _authenticate() async {
    try{
      final bool isAuthenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (isAuthenticated) {
        // Navigate to the next screen or perform the desired action
        Navigator.pushReplacementNamed(context, '/home'); // Replace with your home screen route
      } else {
        // Handle authentication failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication failed')),
        );
      }
    } on PlatformException catch (e) {
      if(e.code == auth_error.notEnrolled) {
        // Handle the case when the user is not enrolled in biometric authentication
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No biometric enrolled')),
        );
      } else if (e.code == auth_error.lockedOut || e.code == auth_error.permanentlyLockedOut) {
        // Handle the case when the user is locked out of biometric authentication
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Biometric authentication locked out')),
        );
      } else {
        // Handle other exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication failed')),
        );
      }
    }
    
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App logo / icon
                const Icon(
                  Icons.lock_outline,
                  size: 70,
                  color: Colors.pink,
                ),
                const SizedBox(height: 40),
                // Fingerprint icon
                InkWell(
                  onTap: _authenticate,
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.fingerprint,
                      size: 60,
                      color: Colors.pinkAccent,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Unlock with fingerprint',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    // Handle PIN input toggle
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Use PIN instead',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
