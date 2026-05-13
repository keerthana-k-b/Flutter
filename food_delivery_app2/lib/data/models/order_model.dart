class OrderModel {
  final String id;
  final String status;
  final List items;
  final double total;

  OrderModel({
    required this.id,
    required this.status,
    required this.items,
    required this.total,
  }); 

  factory OrderModel.fromMap(String id, Map<String, dynamic> map) {
    return OrderModel(
      id: id,
      status: map['status'] ?? 'unknown',
      items: map['items'] ?? [],
      total: (map['total'] ?? 0).toDouble(),
    );
  }
}