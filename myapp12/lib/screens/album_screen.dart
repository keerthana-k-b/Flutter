import 'package:flutter/material.dart';
import 'package:myapp12/models/album_model.dart';
import 'package:myapp12/services/album_service.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {

  final AlbumService _service = AlbumService();

  late Future<List<AlbumModel>> _albums;

  @override
  void initState() {
    super.initState();
    _albums = _service.fetchAlbums();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "API Albums"
        ),
        centerTitle: true,
      ),

      body: FutureBuilder<List<AlbumModel>>(future: _albums, builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child:  CircularProgressIndicator(),
          );
        }

        if(snapshot.hasError){
          print(snapshot.hasError);
          return Center(
            child: Text(
              "Error loading data"
            ),
          );
        }

        final albums = snapshot.data!;

        return ListView.builder(
          itemCount: albums.length,
          itemBuilder: (context,index){

            final album = albums[index];

            return Card(
              margin: EdgeInsets.all(10),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(album.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      album.userId.toString(),
                      style: TextStyle(
                        fontSize: 14
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      album.id.toString(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                ),
            );

        },
        );
      }),

    );
  }
}