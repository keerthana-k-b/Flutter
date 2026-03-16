import 'package:flutter/material.dart';

class Views extends StatefulWidget {
  const Views({super.key});

  @override
  State<Views> createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
            
              child: ListView(
                children: [
                  ListTile(title: Text("Fruits", 
                  style: TextStyle(fontSize: 25,
                  fontWeight:  FontWeight.bold,
                  color:Colors.green))),
                  ListTile(title: Text("Mango")),
                  ListTile(title: Text("Apple")),
                  ListTile(title: Text("Orange")),
                  ListTile(title: Text("Grapes")),
               
              ],
              ),

            ),  
           SizedBox(height: 30),

           Text("sdfghjk"),
            SizedBox(
              height: 200,
              width: 150,
              child: GridView.builder(
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
                 ),
                   itemCount: 6,
                   itemBuilder: (context, index){
                    return Card(child: Center(child: Text("Item $index")),);
                   },
              
              ),
            ),

            Text(
              "hellooo"
            ),
            
            
          ],
        ),
      ),
      
    );
  }
}