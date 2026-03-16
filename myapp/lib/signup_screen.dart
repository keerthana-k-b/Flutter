import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Get Start Now",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            Text(
              "Create account or log in to explore about our app",
              textAlign: TextAlign.center,
             style: TextStyle(
               fontSize:18,
               fontWeight: FontWeight.normal,
                color: const Color.fromARGB(255, 77, 88, 94),
             ),
            ),

            SizedBox(height: 30),
           
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
              Tab(text: "Sign UP"),
              Tab(text: "Log In"),
            ],
          ),
        ),
        ),

        SizedBox(height: 20),

        Row(
        children: [
            Expanded(child:
             Text("First Name")),
            Expanded(child:
             Text("Last Name")),
        ],
      ),

        Row(
        children: [
         Expanded(
      //     child: TextField(
      //     decoration: InputDecoration(
      //     hintText: "First Name",
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(20),
      //     ),
      //   ),
      // ),

      child: TextFormField(
       keyboardType: TextInputType.name,
       decoration: InputDecoration(
        labelText: "Firstname",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        )
       ),
      ),
    ),

    SizedBox(width: 10),

    Expanded(
      child: TextField(
        decoration: InputDecoration(
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
         ),
        ),
       ),
      ],
    ),

        SizedBox(height: 20),

        Row(
          children: [
            Text(
              "Email",
            ),
          ],
        ),

           SizedBox(height: 20),

        TextField(
           decoration: InputDecoration(
               hintText: "abc@gmail.com",
               border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(20),
              ),
            ),
        ),

        SizedBox(height: 20),

        Row(
          children: [
            Text(
              "Date of Birth"
            ),
          ],
        ),

        TextField(
          // controller: _dateController,
          // readOnly: true,
          // onTap: () {
          //   _selectDate(context);
          // },
          decoration: InputDecoration(
            labelText: 'Select date',
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),

        SizedBox(height: 20),

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
          prefixIcon: Icon(Icons.phone),
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          ),
        ),
       ),

       SizedBox(height: 20),

        Row(
         children: [
           Text(
            "Password"
           ),
         ],
       ),

       SizedBox(height: 20),

       TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          ),
        ),
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
          print("Sign Up");
         },
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
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