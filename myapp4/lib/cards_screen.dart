import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Your Cards"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: CarouselSlider(
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: true,
            viewportFraction: 0.9,
          ),

          items: [

            cardWidget("Debit Card", "**** 2478", Colors.blue),

            cardWidget("Visa Card", "**** 4321", Colors.black),

            cardWidget(
              "Credit Card",
              "**** 4567",
              const Color.fromARGB(255, 172, 55, 55),
            ),
          ],
        ),

        
      ),
    );
  }
}

Widget cardWidget(String title, String number, Color color) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 5),
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: color,
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

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Icon(
              Icons.credit_card,
              color: Colors.white,
              size: 28,
            )
          ],
        ),

        const Spacer(),

        Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 2,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          "Valid Thru 12/28",
          style: TextStyle(
            color: Colors.white70,
          ),
        )
      ],
    ),
  );
}