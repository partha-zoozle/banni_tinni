class SharedLinkModel {
  final String id;
  final String url;
  final DateTime timestamp;
  final int clickCount;

  SharedLinkModel({
    required this.id,
    required this.url,
    required this.timestamp,
    this.clickCount = 0,
  });

  factory SharedLinkModel.fromJson(Map<String, dynamic> json) {
    return SharedLinkModel(
      id: json['id'] as String,
      url: json['url'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      clickCount: json['click_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'timestamp': timestamp.toIso8601String(),
      'click_count': clickCount,
    };
  }

  SharedLinkModel copyWith({
    String? id,
    String? url,
    DateTime? timestamp,
    int? clickCount,
  }) {
    return SharedLinkModel(
      id: id ?? this.id,
      url: url ?? this.url,
      timestamp: timestamp ?? this.timestamp,
      clickCount: clickCount ?? this.clickCount,
    );
  }
}