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
      Uri.parse(
          'https://us-central1-ovia-app.cloudfunctions.net/api/save-user-info'),
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

  Future<Map<String, dynamic>?> fetchUserCycle(String userId) async {
    final url = Uri.parse(
        'https://us-central1-ovia-app.cloudfunctions.net/api/get-user-cycle?userId=$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching cycle: $e');
      return null;
    }
  }

  Future<String> postPregnancyInfo({
    required String userId,
    required bool isPregnant,
    weeksPregnant,
    dueDate,
    lmp, //last menstrual period
  }) async {
    weeksPregnant = weeksPregnant;
    dueDate = dueDate;
    lmp = lmp;

    final response = await http.post(
      Uri.parse(
          'https://us-central1-ovia-app.cloudfunctions.net/api/save-pregnancy-info'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'isPregnant': isPregnant,
        'weeksPregnant': weeksPregnant,
        'dueDate': dueDate,
        'lmp': lmp,
      }),
    );

    if (response.statusCode == 200) {
      return 'Pregnancy info submitted successfully';
    } else {
      return 'Failed to post pregnancy info: ${response.body}';
    }
  }

  Future<Map<String, dynamic>?> fetchPregnancyInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    final userId = user.uid;

    final url = Uri.parse(
        'https://us-central1-ovia-app.cloudfunctions.net/api/track-pregnancy?userId=$userId');

    try {
      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error fetching pregnancy info: $e');
      return null;
    }
  }

  static Future<String> submitMoodAndSexData(
      {required Set<String> moods, required String sexOption}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return 'Error: User not logged in';
      }
      final userId = user.uid;

      final response = await http.post(
        Uri.parse(
            'https://us-central1-ovia-app.cloudfunctions.net/api/post-mood-sex'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'moods': moods.toList(),
          'sexOption': sexOption,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Mood and Sex data submitted successfully";
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
        return "Failed to submit Mood and sex data: ${response.body}";
      }
    } catch (e) {
      print('Exception: $e');
      return "Internal server error: $e";
    }
  }
}
