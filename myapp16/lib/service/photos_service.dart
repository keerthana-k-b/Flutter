import 'dart:convert';

import 'package:myapp16/model/photos_model.dart';
import 'package:http/http.dart' as http;

class PhotosService {
  Future<List<PhotosModel>> fetchPhotos() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    
    headers:{
    "Accept":"application/json",
    "User-Agent":"Flutter App"
    },
    
    );

    if(response.statusCode == 200){
      List data = jsonDecode(response.body);

      return data.map((json) => PhotosModel.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load photos');
    }
  }
}