import 'package:album_mvvm_architecture/viewmodels/album_viewmodel.dart';
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

    Provider.of<AlbumViewmodel>(context, listen: false).fetchAlbums();
  }
  
  @override
  Widget build(BuildContext context) {

    final vm = Provider.of<AlbumViewmodel>(context);

    return Scaffold(
       appBar: AppBar(title: Text("Albums"),),

       body: Builder(
        builder: (_){
          if(vm.isLoading){
            return Center(child: Text(vm.error!),);
          }

          return ListView.builder(
            itemCount: vm.albums.length,
            itemBuilder: (context, index){
              final album = vm.albums[index];

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(album.title),
                  subtitle: Text("User: ${album.userId} | ID: ${album.id}"),
                ),
              );
            }
            );
        },
      ),
    );
  }
}