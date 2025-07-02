import 'package:get/get.dart';
import 'package:banni_tinni/app/data/models/link_model.dart';

class LinkProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://bannitinni-api.zoozle.dev/api/v1/';
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.maxAuthRetries = 3;
    super.onInit();
  }

  Future<Response> addLink(String url) async {
    try {
      final response = await post('add/', {'link': url});
      if (response.status.hasError) {
        throw Exception('Failed to add link: ${response.statusText}');
      }
      return response;
    } catch (e) {
      print('Error adding link: $e');
      rethrow;
    }
  }

  Future<LinkResponse> getLinks({int page = 1, int limit = 10}) async {
    try {
      final response = await get(
        'extract_queue',
        query: {'page': page.toString(), 'limit': limit.toString()},
      );

      if (response.status.hasError) {
        print('API Error: ${response.statusText}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load links: ${response.statusText}');
      }

      if (response.body == null) {
        print('Empty response body');
        throw Exception('Failed to load links: Empty response');
      }

      try {
        final linkResponse = LinkResponse.fromJson(response.body);
        if (linkResponse.results.isEmpty && page == 1) {
          print('No links found in response');
        }
        return linkResponse;
      } catch (e) {
        print('Error parsing response: $e');
        print('Response body: ${response.body}');
        throw Exception('Failed to parse links: $e');
      }
    } catch (e) {
      print('Network error: $e');
      rethrow;
    }
  }
}
