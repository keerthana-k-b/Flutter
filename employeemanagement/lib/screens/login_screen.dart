import 'package:employeemanagement/provider/employee_provider.dart';
import 'package:employeemanagement/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailidController = TextEditingController();
  TextEditingController pswdContoller = TextEditingController();
 
 
  bool isPasswordVisible = false;

  void loginEmployeeFunction(BuildContext context) async{
    final provider = Provider.of<EmployeeProvider>(context,listen: false);

    bool  success = await provider.addloginEmployee(
        context,
        email: emailidController.text, 
        password: pswdContoller.text, 
        fcmToken: "",
        );
        if(success){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successfull")),
        );
        }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed")),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 90),

                Text("Get Started now",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
             ),
             Text("Enter your email and password to log in",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.w500
              ),
             ),
             SizedBox(height: 20),

             Text("Email",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: emailidController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:"abc@gmail.com",
                  icon: Icon(Icons.email),
                ),
              ),
             ),
        
             SizedBox(height: 10),

             Text("Password",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
              controller: pswdContoller,
                obscureText: !isPasswordVisible, // toggle
                decoration: InputDecoration(
                 border: InputBorder.none,
                 hintText: "Enter your password",
                 icon: Icon(Icons.lock),

              //  eye icon
                suffixIcon: IconButton(
                 icon: Icon(
                   isPasswordVisible
                    ? Icons.visibility
                     : Icons.visibility_off,
                     ),
                   onPressed: () {
                        setState(() {
                       isPasswordVisible = !isPasswordVisible;
                     });
                   },
                  ),
                ),
               ),
             ),  

             Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: (){},
               child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                ),
               ),
              ),
             ),

              SizedBox(height: 20),
        
             provider.isLoading
             ? CircularProgressIndicator()
             :SizedBox(
               width: double.infinity,
               child: ElevatedButton(
               onPressed: () =>loginEmployeeFunction(context),
               style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                  "Login",
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                 color: Colors.white,
                ),
               ),
              ),
             ),

             SizedBox(height: 20),

             Row(
              children: [
                Expanded(
                  child: Divider(thickness: 0.8)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    
                  ),
                  Expanded(child: Divider(thickness: 0.8)),
              ],
             ),

             SizedBox(height: 90),

             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                     color: Colors.grey[700],
                     fontSize: 12,
                     fontWeight: FontWeight.w500
                  ),
                ),
                TextButton(onPressed: (){
                   Navigator.push(
                     context,
                       MaterialPageRoute(builder: (context) => SignupScreen()),
                   );
                }, 
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 85, 82, 82),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                 ),
                ),
               ),

              ],
             )
            ],
          ),
        ),
      ),
    );
  }
}
