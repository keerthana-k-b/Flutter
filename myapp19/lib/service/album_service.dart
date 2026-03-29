import 'dart:convert';

import 'package:myapp19/model/album_model.dart';
import 'package:http/http.dart' as http;
import 'package:myapp19/model/comments_model.dart';
import 'package:myapp19/model/photos_model.dart';
import 'package:myapp19/model/post_model.dart';
import 'package:myapp19/model/todos_model.dart';
import 'package:myapp19/model/users_model.dart';

class AlbumService{
  Future<List<AlbumModel>> fetchAlbum() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: {
      "Accept": "application/json",
      "User-Agent":"Flutter App"
    },
    );


    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      return data.map((json)=>AlbumModel.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load albums');
    }
    
  }


 Future<List<PostModel>> fetchPosts() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  headers: {
      "Accept": "application/json",
      "User-Agent":"Flutter App"
    },
  );
print(response.body);
  if(response.statusCode == 200){
    List data = jsonDecode(response.body);
    return data.map((json)=>PostModel.fromJson(json)).toList();
  }else{
    throw Exception("Failed to load posts");
  }
 }

 Future<List<CommentsModel>> fetchComments() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'),
  headers: {
      "Accept": "application/json",
      "User-Agent":"Flutter App"
    },
  );

  if(response.statusCode == 200){
    List data = jsonDecode(response.body);
    return data.map((json)=>CommentsModel.fromJson(json)).toList();
  }else{
    throw Exception("Failed to load comments");
  }
 }

Future<List<PhotosModel>> fetchPhotos() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'),
  headers: {
      "Accept": "application/json",
      "User-Agent":"Flutter App"
    },
  );

  if(response.statusCode == 200){
    List data = jsonDecode(response.body);
    return data.map((json)=>PhotosModel.fromJson(json)).toList();
  }else{
    throw Exception("Failed to load comments");
  }
 }

 Future<List<TodosModel>> fetchTodos() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'),
  headers: {
      "Accept": "application/json",
      "User-Agent":"Flutter App"
    },
  );

  if(response.statusCode == 200){
    List data = jsonDecode(response.body);
    return data.map((json)=>TodosModel.fromJson(json)).toList();
  }else{
    throw Exception("Failed to load comments");
  }
 }

 Future<List<UsersModel>> fetchUsers() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'),
  headers: {
    "Accept": "application/json",
    "User-Agent":"Flutter App"
  },
  );

  if(response.statusCode == 200){
    List data=jsonDecode(response.body);
    return data.map((json)=>UsersModel.fromJson(json)).toList();
  }else{
    throw Exception('Failed to load users');
  }
 }

}