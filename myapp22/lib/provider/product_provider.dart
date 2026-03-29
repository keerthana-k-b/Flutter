import 'package:flutter/material.dart';
import 'package:myapp22/model/product_model.dart';
import 'package:myapp22/service/api_service.dart';

class ProductProvider extends ChangeNotifier {

  final ApiService _apiService = ApiService();

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> addProduct({
  required String name,
  required int year,
  required double price,
  required String cpu,
  required String disk,
}) async {
  _isLoading = true;
  notifyListeners();

  final newProduct = await _apiService.createProduct(
    name: name,
    year: year,
    price: price,
    cpu: cpu,
    disk: disk,
  );

  if (newProduct != null) {
    _products.add(newProduct); // ✅ contains ID also
    print("Product Added: ${newProduct.id}");
  } else {
    print("Failed to Add Product");
  }

  _isLoading = false;
  notifyListeners();
}

Future<void> getProducts() async{
  _isLoading = true;
  notifyListeners();

  try{
   _products = await _apiService.fetchProducts();
  }catch(e){
    print(e);
  }

  _isLoading = false;
  notifyListeners();
}

Future<void> updateProduct({
  required String id,
  required String name,
  required int year,
  required double price,
  required String cpu,
  required String disk,
  required String color,
}) async {
  _isLoading = true;
  notifyListeners();

  bool success = await _apiService.updateProduct(
    id: id, 
    name: name, 
    year: year, 
    price: price, 
    cpu: cpu, 
    disk: disk, 
    // color: color,
    );

    _isLoading = false;
    notifyListeners();

    if(success){
      print("Update Success");
      await getProducts(); //refresh list
    }else{
      print("Update Failed");
    }
  }

  Future<void> deleteProduct(String id) async{
    _isLoading = true;
    notifyListeners();

    bool success = await _apiService.deleteProduct(id);

    if(success){
      _products.removeWhere((element) => element.id == id); //remove locally
    }

    _isLoading = false;
    notifyListeners();

    if(success){
      print("Deleted Success");
    }else{
      print("Delete Failed");
    }
  }

}