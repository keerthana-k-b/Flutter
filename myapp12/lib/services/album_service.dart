import 'dart:convert';

import 'package:myapp12/models/album_model.dart';
import 'package:http/http.dart' as http;

class AlbumService {
  Future<List<AlbumModel>> fetchAlbums() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: {
      "Accept": "application/json",
      "User-Agent": "Flutter App"
    },
    );
    print('******');
    print(response.body);
    print(response.statusCode);
    if(response.statusCode == 200) {
      List data = jsonDecode(response.body); // api il aa full data
      print('####');
      return data.map((json) => AlbumModel.fromJson(json)).toList();
    }else{
      throw Exception('Failed to load posts');
    }
  }
}
