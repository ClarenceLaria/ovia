import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class APIs {
  Future<String> postUserSetupInfo({
    required String lastPeriodDate,
    required int cycleLength,
    required int periodDuration,
    birthYear,
    required String cycleType,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid;
    if (user == null) {
      return 'Error: User not logged in';
    }
    birthYear = birthYear ?? '';
    final response = await http.post(
      Uri.parse('https://us-central1-ovia-app.cloudfunctions.net/api/save-user-info'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'lastPeriodDate': lastPeriodDate,
        'cycleLength': cycleLength,
        'periodDuration': periodDuration,
        'birthYear': birthYear,
        'cycleType': cycleType,
      }),
    );

    if (response.statusCode == 200) {
      return 'User info posted successfully';
    } else {
      return 'Failed to post user info: ${response.body}';
    }
  }

}