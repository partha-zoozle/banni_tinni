class PlaceModel {
  final int? id;
  final String name;
  final String address;
  final String googleMapsUrl;
  final String placeId;
  final String description;
  final String remarks;
  final List<String> foodCategory;
  final List<String> items;
  final List<String> images;
  final double latitude;
  final double longitude;
  final String? types;
  final String? website;
  final String? phone;
  final double? rating;
  final int? userRatingsTotal;
  final int? priceLevel;
  final String? businessStatus;
  final String? openingHours;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PlaceModel({
    this.id,
    required this.name,
    required this.address,
    required this.googleMapsUrl,
    required this.placeId,
    required this.description,
    required this.remarks,
    required this.foodCategory,
    required this.items,
    required this.images,
    required this.latitude,
    required this.longitude,
    this.types,
    this.website,
    this.phone,
    this.rating,
    this.userRatingsTotal,
    this.priceLevel,
    this.businessStatus,
    this.openingHours,
    this.createdAt,
    this.updatedAt,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      googleMapsUrl: json['google_maps_url'],
      placeId: json['place_id'] ?? '',
      description: json['description'],
      remarks: json['remarks'],
      foodCategory: List<String>.from(json['food_category']),
      items: List<String>.from(json['items']),
      images: List<String>.from(json['images']),
      latitude: json['latitude']?.toDouble() ?? 0.0,
      longitude: json['longitude']?.toDouble() ?? 0.0,
      types: json['types'],
      website: json['website'],
      phone: json['phone'],
      rating: json['rating']?.toDouble(),
      userRatingsTotal: json['user_ratings_total'],
      priceLevel: json['price_level'],
      businessStatus: json['business_status'],
      openingHours: json['opening_hours'],
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'google_maps_url': googleMapsUrl,
      'place_id': placeId,
      'description': description,
      'remarks': remarks,
      'food_category': foodCategory,
      'items': items,
      'images': images,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class PlaceResponse {
  final List<PlaceModel> results;
  final int count;

  PlaceResponse({required this.results, required this.count});

  factory PlaceResponse.fromJson(Map<String, dynamic> json) {
    return PlaceResponse(
      results:
          (json['results'] as List)
              .map((item) => PlaceModel.fromJson(item))
              .toList(),
      count: json['count'],
    );
  }
}
