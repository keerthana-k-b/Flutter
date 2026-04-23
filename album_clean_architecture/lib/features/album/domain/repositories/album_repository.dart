import 'package:album_clean_architecture/features/album/domain/entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
}