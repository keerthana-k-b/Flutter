import 'package:flutter/material.dart';
import 'package:myapp16/model/photos_model.dart';
import 'package:myapp16/service/photos_service.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {

  final PhotosService _service = PhotosService();
  late Future<List<PhotosModel>> _photos;

  @override
  void initState() {
    super.initState();
    _photos = _service.fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "API Photos"
        ),
        centerTitle: true,
      ),

      body: FutureBuilder<List<PhotosModel>>(
        future: _photos, 
        builder: (context,snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child:  CircularProgressIndicator(),
            );
          }

          if(snapshot.hasError){
            return Center(
              child: Text(
                "Error loading data"
              ),
            );
          }

          final photos = snapshot.data!;

          return ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context,index){

              final photo = photos[index];

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                child:  Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        photo.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        photo.albumId.toString(),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        photo.id.toString(),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        photo.url,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        photo.thumbnailUrl,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),


                    ],
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