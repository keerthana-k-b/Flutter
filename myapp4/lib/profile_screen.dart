import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text("Profile"),
    centerTitle: true,
  ),

  body: Padding(
    padding: EdgeInsets.all(20),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        /// PROFILE IMAGE
        Center(
          child: CircleAvatar(
            radius: 45,
            backgroundColor: Colors.grey.shade300,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.black,
            ),
          ),
        ),

        SizedBox(height: 20),

        /// NAME
        Text(
          "Terry Melton",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 5),

        Text(
          "terrymelton@gmail.com",
          style: TextStyle(color: Colors.grey),
        ),

        SizedBox(height: 30),

        /// PROFILE OPTIONS CARD
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
          ),

          child: Column(
            children: [

              ListTile(
                leading: Icon(Icons.person),
                title: Text("Account"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),

              Divider(),

              ListTile(
                leading: Icon(Icons.lock),
                title: Text("Security"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),

              Divider(),

              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                trailing: Icon(Icons.arrow_forward_ios),
              ),

            ],
          ),
        ),

        SizedBox(height: 30),

        /// LOGOUT BUTTON
        SizedBox(
          width: double.infinity,

          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            onPressed: () {},

            child: Text("Logout",
            style: TextStyle(
              color: Colors.white,
            ),),
          ),
        )

      ],
    ),
  ),
);
  }
}