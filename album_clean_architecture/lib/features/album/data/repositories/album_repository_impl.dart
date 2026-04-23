import 'package:album_clean_architecture/features/album/data/datasources/album_remote_data_source.dart';
import 'package:album_clean_architecture/features/album/domain/entities/album.dart';
import 'package:album_clean_architecture/features/album/domain/repositories/album_repository.dart';

class AlbumRepositoryImpl implements AlbumRepository{
  final AlbumRemoteDataSource remoteDataSource;

  AlbumRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Album>> getAlbums() async{
    return await remoteDataSource.fetchAlbums();
  }
}