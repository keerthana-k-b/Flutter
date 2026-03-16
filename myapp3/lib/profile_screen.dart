import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String lname;
  final String email;
  final String dob;
  final String phone;
  final String pswd;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.lname,
    required this.email,
    required this.dob,
    required this.phone,
    required this.pswd
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Image.asset("assets/images.png"),
                    ),
                    Icon(Icons.shield, color: Colors.blue),
                  ],
                ),
              ),

              SizedBox(height: 30),

              Text("Name"),

              SizedBox(height: 10),

              Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(255, 110, 115, 119),
                    width: 2,
                  ),
                ),
                child: Text("${widget.name} ${widget.lname}"),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Email"),
                  Text("Date of Birth"),
                ],
              ),

              SizedBox(height: 10),

             Row(
  children: [

    Expanded(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color.fromARGB(255, 110, 115, 119),
            width: 2,
          ),
        ),
        child: Text(widget.email),
      ),
    ),

    SizedBox(width: 10),

    Expanded(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color.fromARGB(255, 110, 115, 119),
            width: 2,
          ),
        ),
        child: Text(widget.dob),
      ),
    ),
  ],
),
              SizedBox(height: 20),

              Text("Phone Number"),

              SizedBox(height: 10),

              Container(
                height: 40,
                width: double.infinity,
                // Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(255, 110, 115, 119),
                    width: 2,
                  ),
                ),
                child: Center(child: Text(widget.phone)),
              ),

              SizedBox(height: 20),

              Text("Security"),

              SizedBox(height: 10),

              Container(
                height: 40,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(255, 110, 115, 119),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Change Password: "),
                    Text("********"),
                    // Text(widget.pswd),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Change Password",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Update Profile",
                  ),
                ),
              ),

              SizedBox(height: 10),

              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Logout"),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}