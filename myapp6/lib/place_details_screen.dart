import 'package:flutter/material.dart';
import 'package:myapp6/tour_schedule_screen.dart';

class PlaceDetailsScreen extends StatefulWidget {
  
  final String image;
  final String place;
  const PlaceDetailsScreen({super.key,required this.image, required this.place});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Image.network(
            widget.image,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

         SizedBox(height: 20),

          Text(
            widget.place,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),

         Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Rio de Janeiro is one of Brazil's most iconic cities famous for beaches, mountains and culture.",
              textAlign: TextAlign.center,
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TourScheduleScreen(),
                ),
              );
            },
            child: Text("View Tour"),
          )
        ],
      ),
    );
  }
}