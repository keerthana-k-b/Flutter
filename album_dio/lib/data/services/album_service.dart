import 'package:album_dio/data/datasource/dio/dio_client.dart';
import 'package:album_dio/data/models/album_model.dart';
import 'package:dio/dio.dart';

class AlbumService {
  Future<List<AlbumModel>> fetchAlbums() async {
    try {
      Response response = await DioClient.dio.get('posts');

      List data = response.data;

      return data.map((json) => AlbumModel.fromJson(json)).toList();
    } on DioException catch(e) {
      throw Exception(e.message);
    }
  }
}