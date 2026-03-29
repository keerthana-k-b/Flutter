import 'package:flutter/material.dart';
import 'package:myapp19/model/album_model.dart';
import 'package:myapp19/model/comments_model.dart';
import 'package:myapp19/model/photos_model.dart';
import 'package:myapp19/model/post_model.dart';
import 'package:myapp19/model/todos_model.dart';
import 'package:myapp19/model/users_model.dart';
import 'package:myapp19/service/album_service.dart';

class AlbumProvider  extends ChangeNotifier {
List <AlbumModel> albums = [];
List<PostModel> posts = [];
List<CommentsModel> comments = [];
List<TodosModel> todos = [];
List<PhotosModel> photos = [];
List<UsersModel> users = [];
bool isLoading = false;

final AlbumService _service = AlbumService();

Future<void> getAlbums() async{
  isLoading = true;
  notifyListeners();

  try{
    albums = await _service.fetchAlbum();
  }catch(e){
    print(e);
  }

  isLoading = false;
  notifyListeners();
}


Future<void> getPosts() async{
  isLoading = true;
  notifyListeners();

  try{ 
    posts = await _service.fetchPosts();
  }catch(e){
   print(e);
 }

 isLoading = false;
 notifyListeners();
}

Future<void> getComments() async{

  isLoading= true;
  notifyListeners();

  try{
    comments = await _service.fetchComments();
  }catch(e){
    print(e);
  }

  isLoading = false;
  notifyListeners();
}

Future<void> getTodos() async{
  isLoading= true;
  notifyListeners();

  try{
    todos = await _service.fetchTodos();
  }catch(e){
    print(e);
  }

  isLoading = false;
  notifyListeners();
}

Future<void> getPhotos() async{
  isLoading = true;
  notifyListeners();

try{
    photos = await _service.fetchPhotos();
  }catch(e){
    print(e);
  }

  isLoading = false;
  notifyListeners();

}

Future<void> getUsers() async{
  isLoading = true;
  notifyListeners();

  try {
    users = await _service.fetchUsers();
  }catch(e){
    print(e);
  }

  isLoading = false;
  notifyListeners();
}

}