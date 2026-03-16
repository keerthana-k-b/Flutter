import 'package:flutter/material.dart';
import 'package:myapp8/display_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pswdController = TextEditingController();


  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailController.text);
    await prefs.setString('pswd', _pswdController.text);
  //Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayScreen()),);
   
  }
String text1 = '';
String text2 = '';
  Future<void> display() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      text1 = prefs.getString('email')!;
      text2 = prefs.getString('pswd')!;
      
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
        title: Text(
          "Login Page",
          
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),

            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                )
              ),
            ),

            SizedBox(height: 25),

            TextFormField(
              controller: _pswdController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ) 
              ),
            ),

            SizedBox(height: 30),

            SizedBox(
              width: 400,
              height: 30,
              child: ElevatedButton(  onPressed: saveData,

               child:Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
               ),
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                )
               ),
              ),
            ),

            Text(
              text1
            ),

            Text(
              text2
            ),

          ],
        ),
      ),
    );
  }
}