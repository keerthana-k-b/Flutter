import 'package:flutter/material.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SafeArea(
        child: Column(
          children: [

            /// top icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back,color: Colors.white),
                    onPressed: () {}),
                Row(
                  children:[
                    Icon(Icons.visibility,color: Colors.white),
                    SizedBox(width: 10),
                    Icon(Icons.more_vert,color: Colors.white),
                  ],
                )
              ],
            ),

            SizedBox(height: 40),

            /// product image
            Image.asset(
              "assets/sleeps.jpg",
              height: 200,
            ),

           SizedBox(height: 30),

            /// bottom card
            Expanded(
              child: Container(
                padding:  EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Sleep 30\nDissolvable Wafers",
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
                        onPressed: (){
                          Navigator.pushNamed(context, '/boost');
                        },
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