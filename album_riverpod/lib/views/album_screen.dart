import 'package:album_riverpod/providers/album_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlbumScreen extends ConsumerWidget {
  const AlbumScreen({super.key});

//   @override
//   State<AlbumScreen> createState() => _AlbumScreenState();
// }

//class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final albumAsync = ref.watch(albumProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("API Albums"),
        centerTitle: true,
      ),

      body: albumAsync.when(
         loading: () => Center(
          child: CircularProgressIndicator(),
         ),

         error: (error, stack) => Center(
          child: Text("Error: ${error.toString()}"),
         ),

              data: (albums) {
                 return ListView.builder(
                     itemCount: albums.length,
                     itemBuilder: (context, index) {
                         final album = albums[index];

                    return ListTile(
                      title: Text(album.title),
                      subtitle: Text("User: ${album.userId}"),
                   );
                
              
              
          //      data: (albums){
          // return ListView.builder(
          //   itemCount: albums.length,
          //   itemBuilder: (context,index){

          //     final album = albums[index];

              // return Card(
              //   margin: EdgeInsets.all(10),
              //   elevation: 4,
              //   child: Padding(
              //     padding: EdgeInsets.all(15),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [

              //         Text(
              //           album.title,
              //           style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),

              //         SizedBox(height: 10),

              //         Text(
              //           "User ID: ${album.userId}",
              //           style: TextStyle(fontSize: 14),
              //         ),

              //         SizedBox(height: 15),

              //         Text(
              //           "Album ID: ${album.id}",
              //           style: TextStyle(fontSize: 14),
              //         )
              //       ],
              //     ),
              //   ),
              // );
            },
           );
         },
        ),
    );
  }
}