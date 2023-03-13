class BannerModel {
  final int? id;
  final String? destination;
  final String? title;
  final String? description;
  BannerModel({
    this.id,
    this.destination,
    this.title,
    this.description,
  });

  factory BannerModel.fromJson(Map<dynamic, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      destination: json['destination'] ?? '',
    );
  }
}
