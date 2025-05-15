import 'dart:convert';
import 'package:http/http.dart' as http;

class APIs {
  Future<String> postUserInfo({
    required String userId,
    required String lastPeriodDate,
    required String cycleLength,
    required String periodDuration,
    required String birthYear,
    required String cycleType,
  }) async {
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