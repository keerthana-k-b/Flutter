import 'dart:convert';

import 'package:myapp17/model/todos_model.dart';
import 'package:http/http.dart' as http;

class TodosService {
  Future<List<TodosModel>> fetchTodos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    headers:{
     "Accept": "application/json",
     "User-Agent": "Flutter App"
    },
    );

    if(response.statusCode == 200){
      List data = jsonDecode(response.body);

      return data.map((json)=> TodosModel.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load todos');
    }
  }
}