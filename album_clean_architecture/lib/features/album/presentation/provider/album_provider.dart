import 'package:album_clean_architecture/features/album/domain/entities/album.dart';
import 'package:album_clean_architecture/features/album/domain/usecases/get_albums.dart';
import 'package:flutter/material.dart';

class AlbumProvider with ChangeNotifier{
  final GetAlbums getAlbums;

  AlbumProvider(this.getAlbums);

  List<Album> albums = [];
  bool isLoading = false;

  Future<void> fetchAlbums() async{
    isLoading = true;
    notifyListeners();

    try{
      albums = await getAlbums();
    }catch(e){
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }
}