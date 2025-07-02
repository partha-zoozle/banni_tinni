import 'package:get/get.dart';
import 'package:banni_tinni/app/data/models/place_model.dart';

class PlaceProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://bannitinni-api.zoozle.dev/api/v1/';
    super.onInit();
  }

  Future<Response> addPlace(PlaceModel place) async {
    final response = await post('place/', place.toJson());
    return response;
  }

  Future<PlaceResponse> getPlaces({int page = 1, int limit = 10}) async {
    final response = await get(
      'place/',
      query: {'page': page.toString(), 'limit': limit.toString()},
    );

    if (response.status.hasError) {
      throw Exception('Failed to load places');
    }

    return PlaceResponse.fromJson(response.body);
  }
}
