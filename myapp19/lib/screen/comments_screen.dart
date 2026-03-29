import 'package:flutter/material.dart';
import 'package:myapp19/provider/album_provider.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState(){
    super.initState();

    Provider.of<AlbumProvider>(context,
    listen: false).getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Comments"),
      backgroundColor: Colors.blue,
      centerTitle: true,
     ),

    body: Container(
      padding: EdgeInsets.all(10),
      child: Provider.of<AlbumProvider>(context).isLoading
          ?Center(child: CircularProgressIndicator(),)
            :ListView.builder(
              itemCount: Provider.of<AlbumProvider>(context).comments.length,
              itemBuilder: (context,index){
                final comment = Provider.of<AlbumProvider>(context).comments[index];
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.person, color: Colors.white,),
                           ),
                           SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                comment.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 6),
                        
                        Text(comment.email,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 13,
                        ),
                      ),

                      SizedBox(height: 8),

                      Divider(),

                      SizedBox(height: 8),

                      Text(comment.body,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),

                        Row(
                          children: [
                            Icon(Icons.article, size: 16, color: Colors.grey),
                              SizedBox(width: 4),

                            Text("Post ID: ${comment.postId}"),

                            SizedBox(width: 20),

                            Icon(Icons.tag, size: 16, color: Colors.grey),
                             SizedBox(width: 4),
                               Text("Comment ID: ${comment.id}"),
                          ],
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