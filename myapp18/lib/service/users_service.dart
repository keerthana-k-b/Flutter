import 'dart:convert';

import 'package:myapp18/model/users_model.dart';
import 'package:http/http.dart' as http;

class UsersService {
  Future<List<UsersModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'),
    headers:{
    "Accept" : "application/json",
    "User-Agent" : "Flutter App"
    },
    );

    if(response.statusCode == 200){
      List data = jsonDecode(response.body);

      return data.map((json) => UsersModel.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load users');
    }
  }
}