import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Auth {
  User? get currentUser => FirebaseAuth.instance.currentUser;
  
  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();
   
  Future<String> loginUser(String userEmail, String userPassword) async {
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );

    final idToken = await userCredential.user?.getIdToken();

    final response = await http.post(
      Uri.parse('https://us-central1-ovia-app.cloudfunctions.net/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idToken': idToken}),
    );

    if (response.statusCode == 200) {
      print('Login successful');
      return 'Login successful';
    } else {
      print('Login failed: ${response.body}');
      return 'Login failed: ${response.body}';
    }
  }
}
