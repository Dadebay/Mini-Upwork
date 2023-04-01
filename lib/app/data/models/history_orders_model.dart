class HistoryOrderModel {
  final int? id;
  final int? status;
  final String? phone;
  final String? name;
  final String? description;
  final String? categoryName;
  final String? createdAt;
  HistoryOrderModel({
    this.id,
    this.phone,
    this.name,
    this.description,
    this.categoryName,
    this.status,
    this.createdAt,
  });

  factory HistoryOrderModel.fromJson(Map<dynamic, dynamic> json) {
    return HistoryOrderModel(
      id: json['id'] ?? 0,
      phone: '+993-${json['phone'] ?? ''}',
      status: json['status'] ?? 1,
      createdAt: json['created_at'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      categoryName: json['category_name'] ?? '',
    );
  }
}
