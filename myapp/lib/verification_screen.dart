import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Verification",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

             SizedBox(height: 30),

              Container(
                height:30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.purple),
                  
                ),
                child: Icon(Icons.lock,
                size: 20,
                color: Colors.pinkAccent,),
              ),

              SizedBox(height: 40),

              Text(
                "Verification code",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                
                "Enter the verification code we've sent to your abc@gmail.com",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.purple),
                  ),
                  child: TextField(

                  ),
                  ),

                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.purple),
                  ),
                  child: TextField(
                    
                  ),
                  ),

                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.purple),
                  ),
                  child: TextField(
                    
                  ),
                  ),

                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.purple),
                  ),
                  child: TextField(
                    
                  ),
                  ),
                ],
                
              ),

              SizedBox(height: 30),
            Container(
              height: 30,
              width: 300,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //      backgroundColor: Colors.green,
          //       shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(25),
          //   ),
          // ),onPressed: (){
          //       print("Conform");
          //     }, child: Text(
          //       "Conform",
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black,
          //       ),
          //     ),
          //     ),

          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              ),
            onPressed: (){}, 
            child: Text(
              "Conform",
              style: TextStyle(
                color: const Color.fromARGB(255, 14, 13, 13)
              ),
              ),
              ),

            ),

            SizedBox(height: 30),
            
            Text("Didn't receive the code?Resend",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.pinkAccent,
            ),),



            ],
          ),
        ),
      ),
    );
  }
}