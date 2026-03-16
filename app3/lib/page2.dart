import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [Text("Hello Welcome",
             style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.grey, 
          ),
          ),
          
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Container(
            height: 100,
            width: 100,
            color:Colors.red,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.home, color: Colors.white),
                          SizedBox(height: 5),
                          Text(
                            "Welcome",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
            ),
                ],
            ),
            ),
            ),
           ],
          ),
          SizedBox(height: 30),

           Text("Image Example"),

              
              SizedBox(height: 10),

              // Network image
              Image.network(
                "https://picsum.photos/200",
                height: 100,
              ),

              Text("Icons Row"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.favorite, color: Colors.red),
                  Icon(Icons.share, color: Colors.blue),
                  Icon(Icons.delete, color: Colors.black),
                ],
              ),

              SizedBox(height: 20),

          //back button
          
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Go Back"),
          ),
                ],
          ),
        ),
      ),
    );
  }
}