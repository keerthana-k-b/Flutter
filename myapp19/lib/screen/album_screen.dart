import 'package:flutter/material.dart';
import 'package:myapp19/provider/album_provider.dart';
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

    Provider.of<AlbumProvider>(context,
    listen: false).getAlbums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Albums"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Consumer<AlbumProvider>(
        builder: (context,provider,child){
          if(provider.isLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: provider.albums.length,
            itemBuilder: (context,index){
              final album = provider.albums[index];

              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),

                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue,
                    child: Text(
                      album.id.toString(),
                      style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,
                         ),
                       ),
                    ),
                    title:Text(album.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.person, size: 16, color: Colors.grey),
                         
                         SizedBox(width: 5),
                        
                        Text("UserId : ${album.userId}",
                        style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.photo_album,
                      color: Colors.blue,
                  ),
                ),
              );
            },
          );
          
        },
    ),
    );
  }
}