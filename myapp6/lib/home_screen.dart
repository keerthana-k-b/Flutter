import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:myapp6/place_details_screen.dart' show PlaceDetailsScreen;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> images = [
    "https://img.goodfon.com/original/2048x1344/1/ca/rio-de-janeiro-rio-de-zhaneiro-braziliia-ogni-vid-sverkhu-pa.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkITxZQ_W-YnGInmpgT0v3PHcjHegtElGDmw&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVgeb-BRwln01pnR5iEiSVVnhGk1tqMelT5Q&s"
  ];

  final List<String> places = [
    "Rio de Janeiro",
    "Brazil Mountains",
    "Beach Paradise"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello, Vanessa"),
      ),

      body: Column(
        children: [

         SizedBox(height: 20),

          CarouselSlider.builder(
            itemCount: images.length,

            options: CarouselOptions(
              height: 350,
              enlargeCenterPage: true,
              autoPlay: true,
            ),

            itemBuilder: (context, index, realIndex) {

              return GestureDetector(

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailsScreen(
                        image: images[index],
                        place: places[index],
                      ),
                    ),
                  );
                },

                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),

                    image: DecorationImage(
                      image: NetworkImage(images[index]), // network image
                      fit: BoxFit.cover,
                    ),
                  ),

                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(15),

                  child: Text(
                    places[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}