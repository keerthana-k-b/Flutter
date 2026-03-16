import 'package:flutter/material.dart';

class RelaxScreen extends StatefulWidget {
  const RelaxScreen({super.key});

  @override
  State<RelaxScreen> createState() => _RelaxScreenState();
}

class _RelaxScreenState extends State<RelaxScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Column(
          children: [

            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),

            SizedBox(height: 40),

            Image.asset(
              "assets/relax.jpg",
              height: 200,
            ),

             SizedBox(height: 30),

            Expanded(
              child: Container(
                padding:  EdgeInsets.all(20),
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                     Text(
                      "Relax 30\nDissolvable Wafers",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 10),

                    Text("250 mg"),

                    SizedBox(height: 20),

                     Text(
                      "\$25.50",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),

                    Spacer(),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                        ),
                        onPressed: (){},
                        child:  Text("Buy Now"),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}