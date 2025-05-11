import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> registerUser(String name, String email, String password) async {
  final url = Uri.parse('https://us-central1-ovia-app.cloudfunctions.net/api/register');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name, 'email': email, 'password': password}),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Success: ${response.body}');
    return 'Registration successful';
  } else {
    print('Error: ${response.statusCode} - ${response.body}');
    final error = jsonDecode(response.body);
    return error['message'] ?? 'Registration failed';
  }
}
