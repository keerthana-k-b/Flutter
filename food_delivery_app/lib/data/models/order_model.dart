class OrderModel {
  final String id;
  final double userLat;
  final double userLng;
  final double riderLat;
  final double riderLng;
  final String status;

  final List items;
  final double total;

  OrderModel({
    required this.id,
    required this.userLat,
    required this.userLng,
    required this.riderLat,
    required this.riderLng,
    required this.status,
    required this.items,
    required this.total,
  });

  factory OrderModel.fromMap(String id, Map<String, dynamic> map) {
    return OrderModel(
      id: id,
      userLat: (map['userLat'] ?? 0).toDouble(),
      userLng: (map['userLng'] ?? 0).toDouble(),
      riderLat: (map['riderLat'] ?? 0).toDouble(),
      riderLng: (map['riderLng'] ?? 0).toDouble(),
      status: map['status'] ?? 'unknown',
      items: map['items'] ?? [],
      total: (map['total'] ?? 0).toDouble(),
    );
  }
}