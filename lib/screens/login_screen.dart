import 'package:flutter/material.dart';
import 'package:ovia_app/features/login/custom_text_field.dart';
import 'package:ovia_app/features/login/primary_button.dart';
import 'package:ovia_app/features/login/social_login_button.dart';
import 'package:ovia_app/screens/entry_point.dart';
import 'package:ovia_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ovia-bg.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // const Center(
          //   child: CircularProgressIndicator(),
          // ),
          Column(
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                
                      // Logo
                      Image.asset('assets/icons/ovia_logo_icon.png', height: 50),
                
                      const SizedBox(height: 10),
                
                      // Title
                      Text(
                        "Sign in",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Log in to access your account",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                
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
                      const SizedBox(height: 15),
                
                      // Sign in button
                      PrimaryButton(
                        text: "Sign in",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EntryPoint(),
                            ),
                          );
                        },
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 15),
                
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("or login with",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
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
                      const SizedBox(height: 20),
                
                      // Signup text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? ", 
                            style: TextStyle(fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              Future.microtask(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpScreen(),
                                  ),
                                );
                              });
                            },
                            child: const Text(
                              "Signup",
                              style: TextStyle(
                                color: Colors.pink,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
