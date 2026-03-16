import 'dart:convert';

import 'package:myapp14/models/album_model.dart';
import 'package:http/http.dart' as http;

class AlbumServices {
Future<List<AlbumModel>> fetchAlbums() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  headers: {
    "Accept":"application/json",
    "User-Agent":"Flutter App"
  },
  );

  if(response.statusCode == 200) {
    List data = jsonDecode(response.body);

    return data.map((json) => AlbumModel.fromJson(json)).toList();
  }else{
    throw Exception('Failed to load albums');
  }
}
}