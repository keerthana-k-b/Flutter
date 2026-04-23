import 'package:album_clean_architecture/features/album/presentation/provider/album_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {

  @override
  void initState() {
    super.initState();

    Provider.of<AlbumProvider>(context, listen: false).fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AlbumProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
      ),

      body: provider.isLoading
         ?Center(child: CircularProgressIndicator())
         :ListView.builder(
             itemCount: provider.albums.length,
             itemBuilder: (context, index){
                final album = provider.albums[index];

                return ListTile(
                  title: Text(album.title),
                  subtitle: Text("User: ${album.userId}"),
                );
         },
         ),
    );
  }
}