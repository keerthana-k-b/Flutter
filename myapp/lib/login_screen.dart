import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // appBar: AppBar(
      //   title: Center(
      //     child: Text(
      //       "Welcome Back",
      //       style: TextStyle(
      //         fontSize: 30,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      // ),
body: Center(
  child: SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          Text(
            "Login to access your account",
            style: TextStyle(
              fontSize: 18,
              color: const Color.fromARGB(255, 48, 39, 39),
            ),
          ),

          SizedBox(height: 20),
        //  TabBar(tabs: 
        //  [
        //   Tab(text: "Phone"),
        //   Tab(text: "Email"),
        //  ],
        //  ),

        //  TabBarView(children: [
        //   Center(
        //     child: Padding(
        //       padding: EdgeInsets.all(20),
        //     ),
        //   )
        //  ])

           SizedBox(height: 20), 


        // Tab(
        //   child: Container(
        //     padding: EdgeInsets.all(4),
        //     decoration: BoxDecoration(
        //       color: Colors.green ,
        //       borderRadius: BorderRadius.circular(30),
        //     ),
        //     child: Row(
        //       children: [
        //         Expanded(
        //           child: Text("Phone",
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold
        //           ),
        //           ),
        //         ),
        //         Expanded(
        //           child: Container(
        //             padding: EdgeInsets.symmetric(vertical: 12),
        //             child: Center(
        //               child: Text("Email",
        //               style: TextStyle(fontWeight: FontWeight.bold
        //               ),
        //               ),
        //             ),
        //           )
        //         ),
        //       ],
        //     ),
        //   ),
        // ),


        DefaultTabController(
          length: 2, 
          child: Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.green),
            ),
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
             indicator: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(30),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.green,
            tabs:[
              Tab(text: "Phone"),
              Tab(text: "Email"),
            ],
          ),
        ),
        ),

        SizedBox(height: 30),
       
       Row(
         children: [
           Text(
            "Phone number"
           ),
         ],
       ),
       TextField(
        decoration: InputDecoration(
          hintText: "+91 7890786543",
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          ),
        ),
       ),

       Row(
         children: [
           Text(
            "Password"
           ),
         ],
       ),
       TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          ),
        ),
       ),

       SizedBox(height:20),

       Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                
                value: isChecked, 
                onChanged: (bool? value) { 
                  setState(() {
                  isChecked = value!;
                }); 
                },
                
              ),
              Text("Remember me"),
            ],
          ),
          Text(
            "Forget password?"
          )
        ],
       ),

       SizedBox(height: 20),

       Container(
        height: 50,
        width: 200,
         child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            ),
          ),
          
          onPressed: (){
          print("Log In");
         },
          child: Text(
            "Log In",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
       ),

      SizedBox(height: 20),
      Text(
        "Or Sign In with"),

        SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 30,
              width: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Image.asset("assets/google.png",
                    height: 20,
                    width: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Google",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ],
                    
              ),
           ),


           Container(
              height: 30,
              width: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Image.asset("assets/fb.png",
                    height: 20,
                    width: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Facebook",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ],
                    
              ),
           ),   
          ],
        ),

        SizedBox(height: 40),

            Text("Don't have an account? Sign Up",
            style: TextStyle(
              color: Colors.purpleAccent
            ),
            ),
            
            ],

            
          ),
        ),
      
  ),
),

    );
  }
}