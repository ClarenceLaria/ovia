import 'package:flutter/material.dart';
import 'package:ovia_app/features/login/custom_text_field.dart';
import 'package:ovia_app/features/login/primary_button.dart';
import 'package:ovia_app/features/login/social_login_button.dart';
import 'package:ovia_app/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFFDF6F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // Logo
              Image.asset('assets/icons/ovia_logo_icon.png', height: 50),

              const SizedBox(height: 30),

              // Title
              const Text(
                "Sign in",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Log in to access your account",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 30),

              // Email field
              CustomTextField(
                controller: emailController,
                hintText: "example@gmail.com",
                labelText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password field
              CustomTextField(
                controller: passwordController,
                hintText: "Password",
                labelText: "Password",
                isPassword: true,
              ),
              const SizedBox(height: 8),

              // Remember me checkbox
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Text("Remember me"),
                ],
              ),
              const SizedBox(height: 16),

              // Sign in button
              PrimaryButton(
                text: "Sign in",
                onPressed: () {
                  // TODO: Add sign in logic
                },
              ),
              const SizedBox(height: 20),

              // OR divider
              const Text("or login with", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),

              // Social login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(
                    logoPath: 'assets/icons/google.png',
                    text: 'Google',
                    onTap: () {
                      // TODO: Google login
                    },
                  ),
                  const SizedBox(width: 16),
                  SocialLoginButton(
                    logoPath: 'assets/icons/apple.png',
                    text: 'Apple',
                    onTap: () {
                      // TODO: Apple login
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Signup text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
