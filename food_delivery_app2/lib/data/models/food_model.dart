class FoodModel {
  final String id;
  final String title;
  final double price;
  final String image;
  final String category;
  final String description;

  FoodModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
  });

  factory FoodModel.fromFirestore(Map<String, dynamic> data, String id){
    return FoodModel(
      id: id, 
      title: data['title'] ?? '', 
      price: (data['price'] ?? 0).toDouble(), 
      image: data['image'] ?? '', 
      category: data['category'] ?? '',
      description: data['description'] ?? '',
    );
  }
}