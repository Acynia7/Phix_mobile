import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<void> fetchData(String? token) async {
    final url = Uri.parse('https://std33.beaupeyrat.com/api/sessions');

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
    final url = Uri.parse('https://std33.beaupeyrat.com/api/sessions?code=$sessionCode');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('Response JSON: $responseBody');
      
      // Imprimer toutes les clés et valeurs de la réponse JSON
      responseBody.forEach((key, value) {
        print('Key: $key, Value: $value');
      });

      // Vérifier la structure de la réponse JSON
      if (responseBody is Map && responseBody.containsKey('member')) {
        return responseBody['member'] != null;
      } else {
        print('Erreur: clé "member" manquante dans la réponse JSON');
        return false;
      }
    } else {
      print('Erreur: ${response.statusCode}');
      return false;
    }
  }

  static Future<void> updatePseudo(String sessionCode, String pseudo) async {
    final url = Uri.parse('https://std33.beaupeyrat.com/api/sessions/updatePseudo');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'code': sessionCode,
        'pseudo': pseudo,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Pseudo updated successfully');
    } else {
      print('Erreur: ${response.statusCode}');
    }
  }
}