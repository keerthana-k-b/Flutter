import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayScreen extends StatefulWidget {
  
  const DisplayScreen({super.key});
 
  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
String uname = '';
String emailid = '';
String uage = '';
String phn = '';
String dateob = '';
String pwd = '';

  Future<void> display() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      uname = prefs.getString('name')!;
      emailid = prefs.getString('email')!;
      uage = prefs.getString('age')!;
      dateob = prefs.getString('dob')!;
      phn = prefs.getString('phone')!;
      pwd = prefs.getString('pswd')!;
      
    });

  }
  @override
  void initState(){
    super.initState();
    display();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("User Details"),
       centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          
        
            Container(
              height: 30,
              width: 300,
              
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                uname,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
        
            SizedBox(height: 20),
        
            Container(
              height: 30,
              width: 300,
              
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                emailid,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
        
            SizedBox(height: 20),
        
            Container(
              height: 30,
              width: 300,
              
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                phn,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
        
            SizedBox(height: 20),
        
            Container(
              height: 30,
              width: 300,
              
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                dateob,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
        
            SizedBox(height: 20),
        
            Container(
              height: 30,
              width: 300,
              
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                uage,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
        
            SizedBox(height: 20),
            Container(
              height: 30,
              width: 300,
              
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text(
                pwd,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
        
            
        
          ],
        ),
      ),

    );
  }
}