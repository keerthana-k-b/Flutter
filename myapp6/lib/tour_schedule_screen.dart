import 'package:flutter/material.dart';

class TourScheduleScreen extends StatefulWidget {
  const TourScheduleScreen({super.key});

  @override
  State<TourScheduleScreen> createState() => _TourScheduleScreenState();
}

class _TourScheduleScreenState extends State<TourScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tour Schedule"),
      ),

      body: ListView(
        padding: EdgeInsets.all(20),
        children: [

          Card(
            child: ListTile(
              leading: Icon(Icons.flight),
              title: Text("Day 1"),
              subtitle: Text("Arrival to Rio de Janeiro"),
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.hotel),
              title: Text("Day 2"),
              subtitle: Text("Hotel stay and beach visit"),
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.terrain),
              title: Text("Day 3"),
              subtitle: Text("Mountain adventure tour"),
            ),
          ),

          SizedBox(height: 30),

          ElevatedButton(
            onPressed: null,
            child: Text("Book a Tour"),
          )
        ],
      ),
    );
  }
}