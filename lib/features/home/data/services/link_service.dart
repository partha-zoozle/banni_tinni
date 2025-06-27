import 'dart:convert';
import 'package:http/http.dart' as http;

class LinkService {
  static const String _baseUrl = 'https://api.example.com'; // Temporary API endpoint for testing

  Future<bool> shareLink(String url) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/share'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'url': url,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error sharing link: $e'); // TODO: Implement proper error handling
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getSharedLinks() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/links'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data);
      }
      return [];
    } catch (e) {
      print('Error fetching links: $e'); // TODO: Implement proper error handling
      return [];
    }
  }
}