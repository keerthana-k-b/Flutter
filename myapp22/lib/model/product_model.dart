class ProductModel {
  final String id;
  final String name;
  final Data data;

  ProductModel({
    required this.id,
    required this.name,
    required this.data,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      data: Data.fromJson(json['data'] ?? {}),
    );
  }
}

class Data {
  final int year;
  final double price;
  final String cpu;
  final String disk;

  Data({
    required this.year,
    required this.price,
    required this.cpu,
    required this.disk,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      year: json['year'] ?? 0,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : json['price'] ?? 0.0,
      cpu: json['CPU model']?.toString() ?? '',
      disk: json['Hard disk size']?.toString() ?? '',
    );
  }
}