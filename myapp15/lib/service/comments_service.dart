import 'dart:convert';

import 'package:myapp15/model/comments_model.dart';
import 'package:http/http.dart' as http;

class CommentsService {
  Future<List<CommentsModel>> fetchComments() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'),
    
    headers: {
      "Accept":"application/json",
      "User-Agent":"Flutter App"
    },

    );

    if(response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((json) => CommentsModel.fromJson(json)).toList();
    }else{
      throw Exception('Fail to load comments');
    }
  }
}