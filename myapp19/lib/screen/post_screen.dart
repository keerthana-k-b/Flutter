import 'package:flutter/material.dart';
import 'package:myapp19/provider/album_provider.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  @override
  void initState(){
    super.initState();

    Provider.of<AlbumProvider>(
      context,
      listen: false).getPosts();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text("Posts"),
      centerTitle: true,
       backgroundColor: Colors.blue,
     ),

     body: Container(
      padding: EdgeInsets.all(10),
      child: Provider.of<AlbumProvider>(context).isLoading
          ?Center(child: CircularProgressIndicator())
            :ListView.builder(
              itemCount: Provider.of<AlbumProvider>(context).posts.length,
              itemBuilder: (context,index){
                 final post = Provider.of<AlbumProvider>(context).posts[index];

                 return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                   child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Divider(),

                        SizedBox(height: 6),

                        Row(
                          children: [
                            Icon(Icons.person,size: 18,color: Colors.blue),
                            SizedBox(width: 6),
                            Text("User ID : ${post.userId}",
                             style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),

                        SizedBox(height: 4),

                        Row(
                          children: [
                            Icon(Icons.article,size: 18,color: Colors.blue),
                            SizedBox(width: 6),
                            Text("Post ID : ${post.id}",
                             style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        Text(post.body,
                        style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                   ),
                 );

            }),
     )
    );
  }
}