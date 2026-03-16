import 'package:flutter/material.dart';
import 'package:myapp15/model/comments_model.dart';
import 'package:myapp15/service/comments_service.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

  final CommentsService _service = CommentsService();
  late Future<List<CommentsModel>> _comments;


  @override
   void initState(){
    super.initState();
     _comments = _service.fetchComments();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "API Comments"
        ),
        centerTitle: true,
      ),

      body: FutureBuilder<List<CommentsModel>>(
        future: _comments, 
        builder: (context,snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator()
            );
          }

          if(snapshot.hasError){
            return Center(
              child: Text(
                "Error loading data"
              )
            );
          }

          final comments = snapshot.data!;

          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context,index){

              final comment = comments[index];

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        comment.postId.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        comment.id.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        comment.email,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        comment.body,
                        style: TextStyle(
                          fontSize: 18,
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