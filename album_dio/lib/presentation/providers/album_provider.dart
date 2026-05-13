import 'package:album_dio/data/models/album_model.dart';
import 'package:album_dio/data/services/album_service.dart';
import 'package:flutter/material.dart';

class AlbumProvider extends ChangeNotifier{

  final AlbumService _service = AlbumService();

  List<AlbumModel> albums = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchAlbums() async {
   isLoading = true;
   errorMessage = '';
   notifyListeners();

   try{
    albums = await _service.fetchAlbums();
   }catch(e) {
    errorMessage = e.toString();
   }

   isLoading = false;
   notifyListeners();

  }
}