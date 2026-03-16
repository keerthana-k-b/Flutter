import 'package:flutter/material.dart';
import 'package:myapp7/task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/girl.png"),
                fit: BoxFit.cover
                ),
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Task Management & \n To - Do List",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
            
                  SizedBox(height: 15),
            
                  Text(
                    "This productive tool is designed to help\nyou better manage your task \nproject-wise conveniently! ",
                     textAlign: TextAlign.center,
                     style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w200,
                      color: const Color.fromARGB(255, 59, 57, 57),
                    ),
                  ),
            
                 SizedBox(height: 30),
            
                 Container(
                  //height: 20,
                  width: 250,
                   child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context)=>TaskScreen()
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Color.fromARGB(255, 94, 3, 117),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                     ),
                   ),
                   
                   
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Let's Start",
                           style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                      
                      SizedBox(width: 10),
                     Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                   ),
                  ],
                    ),
                   ),
                 ) ,
                ],
              ),
            ),
          ],
        ),
        
        ),
      ),
    );
  }
}