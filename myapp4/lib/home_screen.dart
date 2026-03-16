import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good morning, Terry",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              
                      SizedBox(height: 4),
              
                      Text(
                        "Welcome to Noebank",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                     
                    ],
                  ),
              
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Icon(Icons.notifications_none,),
                  ),
                ],
              ),

              SizedBox(height: 20),

             Container(
  padding: EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
      )
    ],
  ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text(
  "Your balance",
  style: TextStyle(color: Colors.grey),
),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$3,200.00",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                   

                  Icon(Icons.visibility_off),
                   ],
                  ),

                  SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                        onPressed: () {},

                        child: Text("Add money",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                    ),

                    SizedBox(height: 20),

                    
                    SizedBox(height: 20),

                    //Add "Your Cards + New Card" Title Row

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Cards",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        TextButton(
                          onPressed: (){}, 
                          child: Text(
                            "+ New Card"
                          ),
                          ),
                      ],
                    ),

                    //Add Horizontal Card Slider

                  SizedBox(
                     width: double.infinity,
                      child: CarouselSlider(
                          options: CarouselOptions(
                          height: 180,
                          autoPlay: true,
                           enlargeCenterPage: true,
                            viewportFraction: 0.85,
                  ),
                 items: [
                  bankCard("Debit Card", "**** 2478", Colors.blue),
                  bankCard("Visa Card", "**** 4321", Colors.black),
                  bankCard("Credit Card", "**** 4567", Color.fromARGB(255, 172, 55, 55)),
                ],
              ),
             ),


                ],
              ),
              ),


            ],
          ),
              

        ),
        
      ),

      //BottomNavigator

        bottomNavigationBar: BottomNavigationBar(
           currentIndex: 0,
           type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card),label: "Cards"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
        ],

        // onTap: (index) {

        //   if(index==1){
        //     Navigator.push(//context,
        //       MaterialPageRoute(builder: (context)=>CardsScreen()));
        //   }

        //   if(index==2){
        //     Navigator.push(context,
        //       MaterialPageRoute(builder: (context)=>ProfileScreen()));
        //   }

        // },
      ),
      
    );
  }
}

//Create Bank Card Widget

Widget bankCard(String title, String number, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(20),
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),

        Spacer(),

        Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),

      ],
    ),
  );
}