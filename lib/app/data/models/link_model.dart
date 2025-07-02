class LinkModel {
  final int id;
  final String link;
  final String status;
  final String? placeId;
  final String? placeDataId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  LinkModel({
    required this.id,
    required this.link,
    required this.status,
    this.placeId,
    this.placeDataId,
    required this.createdAt,
    this.updatedAt,
  });

  factory LinkModel.fromJson(Map<String, dynamic> json) {
    return LinkModel(
      id: json['id'] as int,
      link: json['link'] as String,
      status: json['status'] as String,
      placeId: json['place_id']?.toString(),
      placeDataId: json['place_data_id']?.toString(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'] as String)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'link': link,
      'status': status,
      'place_id': placeId,
      'place_data_id': placeDataId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class LinkResponse {
  final List<LinkModel> results;
  final int count;

  LinkResponse({required this.results, required this.count});

  factory LinkResponse.fromJson(Map<String, dynamic> json) {
    return LinkResponse(
      results:
          (json['results'] as List)
              .map((item) => LinkModel.fromJson(item as Map<String, dynamic>))
              .toList(),
      count: json['count'] as int,
    );
  }
}
