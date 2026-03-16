import 'package:flutter/material.dart';
import 'package:myapp8/display_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingupScreen extends StatefulWidget {
  const SingupScreen({super.key});

  @override
  State<SingupScreen> createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
TextEditingController _nameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _phoneController = TextEditingController();
TextEditingController _ageController = TextEditingController();
TextEditingController _dobController = TextEditingController();
TextEditingController _pswdController = TextEditingController();

Future<void> saveData() async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('name',_nameController.text);
  await prefs.setString('email',_emailController.text);
  await prefs.setString('phone',_phoneController.text);
  await prefs.setString('age',_ageController.text);
  await prefs.setString('dob',_dobController.text);
  await prefs.setString('pswd',_pswdController.text);
  Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayScreen()),);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registration",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Name"
                ),
              ],
            ),
            SizedBox(height: 10),
            
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                )
              ),
            ),

            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Email"
                ),
              ],
            ),

            SizedBox(height: 10),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                )
              ),
            ),

            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Phone"
                ),
              ],
            ),
            SizedBox(height: 10),
            
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone",
                prefixIcon: Icon(Icons.phone_android),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                )
              ),
            ),

            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Date of Birth"
                ),
              ],
            ),
            SizedBox(height: 10),
            
            TextFormField(
              controller: _dobController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: "dd/mm/yyyy",
                prefixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                )
              ),
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Age"
                ),
              ],
            ),

            SizedBox(height: 15),

            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                )
              ),
            ),

            SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Password"
                ),
              ],
            ),

            SizedBox(height: 10),

            TextFormField(
              controller: _pswdController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey.shade100),
                )
              ),
            ),
            SizedBox(height: 15),

            Container(
              height: 30,
              width: 250,
              child: ElevatedButton(onPressed: saveData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                )
              ),
               child: Text(
                "Register",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
               ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}