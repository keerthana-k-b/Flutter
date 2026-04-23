import 'package:album_mvvm_architecture/models/album_model.dart';
import 'package:album_mvvm_architecture/services/album_service.dart';
import 'package:flutter/material.dart';

class AlbumViewmodel extends ChangeNotifier{
  final AlbumService _service = AlbumService();
  

  List<AlbumModel> albums = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchAlbums() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try{
      albums = await _service.fetchAlbums();
    }catch(e){
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}