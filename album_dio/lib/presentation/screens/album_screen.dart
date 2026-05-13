import 'package:album_dio/presentation/providers/album_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {

  @override
  void initState(){
    super.initState();
    Future.microtask(() {
      context.read<AlbumProvider>().fetchAlbums();
    });
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlbumProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Album "),
        centerTitle: true,
      ),

      body: provider.isLoading
             ?Center(
              child: CircularProgressIndicator(),
             )
             :provider.errorMessage.isNotEmpty
                ?Center(
                  child: Text(provider.errorMessage),
                )
                
                :ListView.builder(
                  itemCount: provider.albums.length,
                  itemBuilder: (context, index) {
                      final album = provider.albums[index];

                    return Card(

                      margin: const EdgeInsets.all(10),

                      child: Padding(

                        padding: const EdgeInsets.all(15),

                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Text(
                              album.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text("User ID : ${album.userId}"),

                            const SizedBox(height: 10),

                            Text("Post ID : ${album.id}"),

                            const SizedBox(height: 10),

                            Text(album.body),

                          ],
                        ),
                      ),
                    );
                  }
                ),
    );
  }
}