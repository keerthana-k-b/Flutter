import 'package:flutter/material.dart';
import 'package:myapp7/add_project_screen.dart';
import 'package:myapp7/home_screen.dart';
import 'package:myapp7/task_screen.dart';

class LastScreen extends StatefulWidget {
  const LastScreen({super.key});

  @override
  State<LastScreen> createState() => _LastScreenState();
}

class _LastScreenState extends State<LastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      // FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=>AddProjectScreen(),
            ),
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
      child: Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        IconButton(
          icon: Icon(Icons.home, color: Colors.deepPurple),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>HomeScreen()),
            );
          },
        ),

        IconButton(
          icon: Icon(Icons.calendar_month, color: Colors.grey),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>TaskScreen()),
            );
          },
        ),

        SizedBox(width: 40),

        IconButton(
          icon: Icon(Icons.description, color: Colors.grey),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>TaskScreen()),
            );
          },
        ),

        IconButton(
          icon: Icon(Icons.people, color: Colors.grey),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>HomeScreen()),
            );
          },
        ),

      ],
    ),
  ),
),

appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  iconTheme: IconThemeData(color: Colors.black),
),

      // DRAWER
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              accountName: Text("Livia Vaccaro"),
              accountEmail: Text("livia@email.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/profile.jpeg"),
              ),
            ),

            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: (){
                    Navigator.pop(context);

                   Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context)=>HomeScreen()),
                    );
                  },
            ),

            ListTile(
              leading: Icon(Icons.task),
              title: Text("Today's Tasks"),
              onTap: () {
                Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context)=>TaskScreen()
                   ),
                  );
              },
            ),

            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text("Calendar"),
              onTap: () {},
            ),

            ListTile(
              leading: Icon(Icons.folder),
              title: Text("Projects"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>AddProjectScreen()
                  ),
                  );
              },
            ),

            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),

            Divider(),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {},
            ),
          ],
        ),
      ),

      // BODY
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // HEADER
                Row(
                  children: [

                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/profile.jpeg"),
                    ),

                    SizedBox(width: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello!",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "Livia Vaccaro",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    Spacer(),

                    Icon(Icons.notifications, size: 28),
                  ],
                ),

                SizedBox(height: 25),

                // PURPLE CARD
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.purple],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Your today's task\nalmost done!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),

                          SizedBox(height: 15),

                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "View Task",
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 6,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "85%",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 25),

                // IN PROGRESS TITLE
                Row(
                  children: [

                    Text(
                      "In Progress",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(width: 8),

                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        "6",
                        style: TextStyle(fontSize: 12),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 15),

                // PROGRESS CARDS
                Row(
                  children: [

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Office Project"),
                            SizedBox(height: 10),

                            Text(
                              "Grocery shopping\napp design",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 10),

                            LinearProgressIndicator(value: 0.7),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 15),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("Personal Project"),
                            SizedBox(height: 10),

                            Text(
                              "Uber Eats redesign\nchallenge",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 10),

                            LinearProgressIndicator(value: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25),

                // TASK GROUP TITLE
                Text(
                  "Task Groups",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 15),

                taskGroup("Office Project", "23 Tasks", "70%"),
                SizedBox(height: 12),

                taskGroup("Personal Project", "30 Tasks", "52%"),
                SizedBox(height: 12),

                taskGroup("Daily Study", "30 Tasks", "87%"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget taskGroup(String title, String subtitle, String percent) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: TextStyle(color: Colors.grey)),
            ],
          ),

          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.deepPurple,
                width: 4,
              ),
            ),
            child: Center(
              child: Text(percent),
            ),
          )
        ],
      ),
    );
  }
}