import 'package:flutter/material.dart';
import 'package:myapp7/add_project_screen.dart';
import 'package:myapp7/home_screen.dart';
import 'package:myapp7/last_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      //floating button

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(
              builder: (context)=> AddProjectScreen()
            ),
          );
         },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        //Bottom Navigation

        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                icon: Icon(Icons.calendar_month, color: const Color.fromARGB(255, 86, 43, 160)),
                onPressed:()
               {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>LastScreen()
                  ),
                );
               },
              ),

              SizedBox(width: 40),
              IconButton(
                   icon: Icon(Icons.description_outlined, color: Colors.deepPurple),
                   onPressed: (){
                   Navigator.push(
                   context,
                     MaterialPageRoute(builder: (context)=>AddProjectScreen()),
                   );
                 },
               ),
               IconButton(
                icon: Icon(Icons.people_outline, color: const Color.fromARGB(255, 86, 43, 160)),
                onPressed:()
               {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=>LastScreen()
                  ),
                );
               },
              ),

              ],
            ),
          ),
        ),

        //body

        body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text("Today's Tasks",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  Icon(Icons.notifications_none),
                ],
              ),

              SizedBox(height: 20),
              
              // Date Scroll
              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    dateCard("May", "23", "Fri", false),
                    dateCard("May", "24", "Sat", false),
                    dateCard("May", "25", "Sun", true),
                    dateCard("May", "26", "Mon", false),
                    dateCard("May", "27", "Tue", false),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Filter Buttons
              Row(
                children: [
                  filterButton("All", true),
                  filterButton("To do", false),
                  filterButton("In Progress", false),
                ],
              ),

              SizedBox(height: 20),

               // Task List
              Expanded(
                child: ListView(
                  children: [
                    taskCard(
                        "Grocery shopping app design",
                        "Market Research",
                        "10:00 AM",
                        "Done"),

                    taskCard(
                        "Grocery shopping app design",
                        "Competitive Analysis",
                        "12:00 PM",
                        "In Progress"),

                    taskCard(
                        "Uber Eats redesign challenge",
                        "Create Low-fidelity Wireframe",
                        "07:00 PM",
                        "To-do"),

                    taskCard(
                        "About design sprint",
                        "How to pitch a Design Sprint",
                        "09:00 PM",
                        "To-do"),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }

   // Date Card
  Widget dateCard(month, date, day, selected) {
    return Container(
      width: 70,
      margin:  EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.deepPurple : Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(month,
              style: TextStyle(
                  color: selected ? Colors.white : Colors.black54)),
          Text(date,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.black)),
          Text(day,
              style: TextStyle(
                  color: selected ? Colors.white : Colors.black54)),
        ],
      ),
    );
  }


  // Filter Buttons
  Widget filterButton(text, active) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: active ? Colors.deepPurple : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: active ? Colors.white : Colors.deepPurple,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

// Task Card
  Widget taskCard(title, task, time, status) {
    return Container(
      margin:  EdgeInsets.only(bottom: 16),
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),

          SizedBox(height: 6),

          Text(
            task,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),

         SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                   Icon(Icons.access_time,
                      size: 16, color: Colors.deepPurple),
                  const SizedBox(width: 5),
                  Text(time,
                      style: const TextStyle(
                          color: Colors.deepPurple)),
                ],
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(status),
              )
            ],
          )
        ],
      ),
    );
  }


} 