
import 'package:album_riverpod/models/album_model.dart';
import 'package:album_riverpod/services/album_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//  Dependency Injection happens here
final albumServiceProvider = Provider<AlbumService>((ref) {
  return AlbumService();
});

//  Using injected service
final albumProvider = FutureProvider<List<AlbumModel>>((ref) async {
  final service = ref.watch(albumServiceProvider); //  DI here
  return service.fetchAlbums();
});

// final albumServiceProvider = Provider((ref) => AlbumService());


// final albumProvider = FutureProvider<List<AlbumModel>>((ref) async {
//   final service = ref.watch(albumServiceProvider);
//   return service.fetchAlbums();
// });