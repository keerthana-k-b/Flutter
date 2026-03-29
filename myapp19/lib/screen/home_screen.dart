import 'package:flutter/material.dart';
import 'package:myapp19/screen/album_screen.dart';
import 'package:myapp19/screen/comments_screen.dart';
import 'package:myapp19/screen/photos_screen.dart';
import 'package:myapp19/screen/post_screen.dart';
import 'package:myapp19/screen/todos_screen.dart';
import 'package:myapp19/screen/users_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Data Screens"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                   width: double.infinity,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 18),
                     textStyle: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     ),
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                ),
                 onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AlbumScreen()),);
              }, child: Text(
                "Albums"
              ),
              ),
              ),
          
          SizedBox(height: 15),

               SizedBox(
                   width: double.infinity,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 18),
                     textStyle: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     ),
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                ),
                 onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen()),);
              }, child: Text(
                "Posts"
              ),
              ),
               ),

              SizedBox(height: 15),
          
               SizedBox(
                   width: double.infinity,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 18),
                     textStyle: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     ),
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                ),
                 onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CommentsScreen()),);
              }, child: Text(
                "Comments"
              ),
              ),
               ),

              SizedBox(height: 15),
          
               SizedBox(
                   width: double.infinity,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 18),
                     textStyle: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     ),
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                ),
                 onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotosScreen()),);
              }, child: Text(
                "Photos"
              ),
              ),
               ),
          
          SizedBox(height: 15),
          
               SizedBox(
                   width: double.infinity,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 18),
                     textStyle: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     ),
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                ),
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TodosScreen()),);
              }, child: Text(
                "Todos"
              ),
              ),
               ),

               SizedBox(height: 15),
          
               SizedBox(
                   width: double.infinity,
                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 18),
                     textStyle: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold,
                     ),
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                ),
                onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersScreen()),);
              }, child: Text(
                "Users"
              ),
              ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}