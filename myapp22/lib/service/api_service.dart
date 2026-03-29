import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp22/model/product_model.dart';

class ApiService {
  static String posturl = "https://api.restful-api.dev/objects";
  static String geturl = "https://api.restful-api.dev/objects";
  static String puturl = "https://api.restful-api.dev/objects";

  Future<ProductModel?> createProduct({
    required String name,
    required int year,
    required double price,
    required String cpu,
    required String disk,
  }) async {
    try{
      final body = {
        "name":name,
        "data":{
          "year":year,
          "price":price,
          "CPU model":cpu,
          "Hard disk size":disk,
        }
      };

      final response = await http.post(Uri.parse(posturl),
      headers:{
        "Content-Type":"application/json"
      },
      body:jsonEncode(body),
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        final json = jsonDecode(response.body);

      //  RETURN FULL OBJECT WITH ID
      return ProductModel.fromJson(json);

      }else{
        print("Error:${response.body}");
        return null;
      }
    }catch(e){
      print("Exception: $e");
      return null;
    }
  }


Future<List<ProductModel>> fetchProducts() async{
  try{
  final response = await http.get(Uri.parse(geturl),
  );

  if(response.statusCode == 200){
    List jsonData = jsonDecode(response.body);

    return jsonData.map((e) => ProductModel.fromJson(e)).toList();
  }else{
    throw Exception("Failed to load products");
  }
}catch(e){
  throw Exception("Error $e");
}
}


Future<bool> updateProduct({
  required String id,
  required String name,
  required int year,
  required double price,
  required String cpu,
  required String disk,
  //required String color,
}) async {
  try{
    final body = {
      "name" : name,
      "data":{
        "year": year,
        "price" : price,
        "CPU model" : cpu,
        "Hard disk size" : disk,
       // "color" : color,
      }
    };

    final response = await http.put(Uri.parse("$puturl/$id"),
    headers: {
      "Content-Type":"application/json"
    },
    body: jsonEncode(body),
    );

    if(response.statusCode == 200){
      print("Updated: ${response.body}");
      return true;
    }else{
      print("Error: ${response.body}");
      return false;
    }
  }catch(e){
    print("Exception: $e");
    return false;
  }
}

Future<bool> deleteProduct(String id) async{
  try{
    final response = await http.delete(Uri.parse("$geturl/$id"),
    );

    if(response.statusCode == 200){
      print("Deleted: ${response.body}");
      return true;
    }else{
      print("Error: ${response.body}");
      return false;      
    }
  }catch(e){
  print("Exception: $e");
  return false;
  }
}

}