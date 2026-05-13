import 'package:flutter/material.dart';
import 'package:food_delivery_app2/data/models/food_model.dart';
import 'package:food_delivery_app2/data/services/food_service.dart';

class FoodProvider extends ChangeNotifier{
   final FoodService _foodService = FoodService();

   int selectedIndex = 0;
   String selectedCategory = ""; 

  List<Map<String, dynamic>> categories = [
    {"icon": Icons.all_inclusive, "name": "All"},
    {"icon": Icons.fastfood, "name": "Burger"},
    {"icon": Icons.local_drink, "name": "Juice"},
    {"icon": Icons.local_pizza, "name": "Salad"},
    {"icon": Icons.ramen_dining, "name": "Fries"},
  ];

  void selectCategory(int index) {
    selectedIndex = index;
    if (categories[index]["name"] == "All") {
      selectedCategory = "";
    } else {
      selectedCategory = categories[index]["name"];
    }
    notifyListeners();
  }

   Stream<List<FoodModel>> get foodsStream => _foodService.getFoodsByCategory(selectedCategory);

   Stream<List<FoodModel>> searchFoods(String query) {
     return _foodService.searchFood(query);
  }
}