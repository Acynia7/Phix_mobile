import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> fetchData(String? token) async {
    final url = Uri.parse('https://localhost/api/sessions');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      print('Erreur: ${response.statusCode}');
    }
  }

  static Future<bool> verifySessionCode(String sessionCode) async {
    final url = Uri.parse('https://localhost/api/sessions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'sessionCode': sessionCode}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['exists'] as bool;
    } else {
      print('Erreur: ${response.statusCode}');
      return false;
    }
  }
}