import 'package:flutter/material.dart';
import 'package:myapp19/provider/album_provider.dart';
import 'package:provider/provider.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  void initState(){
    super.initState();

    Provider.of<AlbumProvider>(context,
    listen: false).getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text("Photos"),
      centerTitle: true,
      backgroundColor: Colors.blue,
     ),

      body: Container(
      padding: EdgeInsets.all(10),
      child: Provider.of<AlbumProvider>(context).isLoading
          ?Center(child: CircularProgressIndicator(),)
            :ListView.builder(
              itemCount: Provider.of<AlbumProvider>(context).photos.length,
              itemBuilder: (context,index){
                final photo = Provider.of<AlbumProvider>(context).photos[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                      Text(photo.title,
                      
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      ),

                      SizedBox(height: 6),
                      
                       Text(
                        "Album ID : ${photo.albumId}",
                        style: TextStyle(
                          color: Colors.grey[700]
                        ),
                        ),
                       Text(
                        "Photo ID : {photo.id}",
                        style: TextStyle(
                          color: Colors.grey[700]
                        ),
                        ),
                       Text(
                        "URL: ${photo.url}",
                       style: TextStyle(
                          fontSize: 12,
                          color: Colors.blueAccent,
                        ),
                       ),
                       Text(
                        "Thumnail: ${photo.thumnailUrl}",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                        ),
                     ],
                                          ),
                  ),
                );
            })
    ),
    );
  }
}