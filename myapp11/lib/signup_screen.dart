import 'package:flutter/material.dart';
import 'package:myapp11/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dateofbirthController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _pswdController = TextEditingController();

  

  Future<void> saveData() async {

    if(_fnameController.text.isEmpty ||  //check if fields are empty
      _emailController.text.isEmpty ||
      _pswdController.text.isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please fill all required fields")),
    );
    return;
  }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fname', _fnameController.text);
    await prefs.setString('lname', _lnameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('dob', _dateofbirthController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('address', _addressController.text);
    await prefs.setString('pswd', _pswdController.text);

    String fullname = "${_fnameController.text} ${_lnameController.text}";

    await prefs.setString('name', fullname);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()),);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registration",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "First Name"
                  ),
                  SizedBox(width: 110),
                  Text(
                    "Last Name"
                  ),
                ],
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _fnameController,
                        decoration: InputDecoration(
                          hintText: "FirstName",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _lnameController,
                        decoration: InputDecoration(
                          hintText: "LastName",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
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

              Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _dateofbirthController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_month),
                        hintText: "DD/MM/YYYY",
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                   SizedBox(height: 15),

                  Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number"
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android),
                        hintText: "+91 9878909876",
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                   SizedBox(height: 15),

                  Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Address"
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        hintText: "Address",
                        border: InputBorder.none,
                      ),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _pswdController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: "****",
                        border: InputBorder.none,
                      ),
                      obscureText: true,
                    ),
                  ),

                  SizedBox(height: 20),

                  Container(
                    width: 250,
                    height: 30,
                    child: ElevatedButton(onPressed: saveData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ), 
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                     ),
                   ),
                 ),
               ),
            ],
          ),
        ),
      ),

    );
  }
}