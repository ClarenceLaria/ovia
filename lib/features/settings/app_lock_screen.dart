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
  bool _authFailed = false;

  Future<void> _authenticate() async {
    try {
      final bool isAuthenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to continue',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() => _authFailed = true);
      }
    } on PlatformException catch (e) {
      String errorMsg = 'Authentication failed';
      if (e.code == auth_error.notEnrolled) {
        errorMsg = 'No biometric enrolled';
      } else if (e.code == auth_error.lockedOut || e.code == auth_error.permanentlyLockedOut) {
        errorMsg = 'Biometric authentication locked out';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMsg)),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const themeColor = Colors.pinkAccent;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF0F6), Color(0xFFFFC4E0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Icon
                  const Icon(
                    Icons.lock_rounded,
                    size: 80,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black26, blurRadius: 10)],
                  ),
                  const SizedBox(height: 30),

                  // Fingerprint Scan Area
                  GestureDetector(
                    onTap: _authenticate,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color: themeColor.withOpacity(0.25),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.fingerprint,
                        size: 60,
                        color: _authFailed ? Colors.redAccent : themeColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  Text(
                    _authFailed ? 'Try again' : 'Tap to unlock with fingerprint',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Use PIN Instead Button
                  TextButton(
                    onPressed: () {
                      // Navigate to PIN screen or show input field
                      Navigator.pushNamed(context, '/pin'); 
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 3,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Use PIN instead',
                      style: TextStyle(
                        color: themeColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
