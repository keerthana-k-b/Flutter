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
        backgroundColor: const Color.fromARGB(255, 101, 72, 150),
        title: Text(
          "Welcome to Container",
          style: TextStyle(
            color: Colors.black87
          ),
        ),
      ),

drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.purple,),
                child: Text('Welcome ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  ),
              ),
              ),
              ListTile(title: Text('Item 1'),
              leading: Icon(Icons.people),
              ),
              ListTile( title: Text('Item 2'),
              leading: Icon(Icons.mail),
              ),
            ],
          ),
         ),

      body: Center(
        child: SingleChildScrollView( 
         child: Column(
         children: [
          Image.asset("assets/cat.PNG"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300,
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black,
                width: 3),
              ),
              child: Text("Hello I am inside a container!",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white
              ),),
            ),
           
          ),

          Container(
            height: 200,
            width: double.infinity,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(30),
            color: Colors.brown,
            transform: Matrix4.rotationZ(0.1),
            child: Text("Hello I am inside a container!",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white30
            ),),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                FloatingActionButton(backgroundColor: Colors.green,
                elevation: 10.0,
                child: Icon(Icons.add,
                color: Colors.white,),onPressed:(){
                
                },
                ),
                FloatingActionButton(backgroundColor: const Color.fromARGB(255, 7, 93, 104),
                elevation: 10.0,
                child: Icon(Icons.home,
                color: const Color.fromARGB(255, 15, 196, 54),),onPressed:(){
                
                },
                ),
              ],
            ),
          ),
         
        ],
        
      ),
      
        ),
      ),
      bottomNavigationBar:BottomNavigationBar(
        currentIndex: 0,
        fixedColor: Colors.green,
         items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle),
          ),
         ],
         onTap: (int indexOfItem){}
      ),
    );
  }
}