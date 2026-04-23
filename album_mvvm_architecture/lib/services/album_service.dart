import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:album_mvvm_architecture/models/album_model.dart';

class AlbumService {
  Future<List<AlbumModel>> fetchAlbums() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: {
      "Accept": "application/json",
      "User-Agent": "Flutter App"
    },
    );

    print("STATUSCODE: ${response.statusCode}");
    print("BODY: ${response.body}");

    if(response.statusCode == 200){
      List data = jsonDecode(response.body);
      return data.map((e) => AlbumModel.fromJson(e)).toList();
    }else{
      throw Exception('Failed to load albums');
    }
  }
}