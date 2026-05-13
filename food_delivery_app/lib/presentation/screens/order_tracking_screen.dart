// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:food_delivery_app/presentation/providers/tracking_provider.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:provider/provider.dart';

// class OrderTrackingScreen extends StatefulWidget {
//   const OrderTrackingScreen({super.key});

//   @override
//   State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
// }

// class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
//   final MapController _mapController = MapController();
  
//   // LatLng? currentLatLng;
//   // List<LatLng> routePoints = [];

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   initLocation();
//   // }

// //   //GET CURRENT Location
// //   Future<void> initLocation() async {
// //    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //    if (!serviceEnabled) {
// //      throw Exception('Location services disabled');
// //    }
   
// //    LocationPermission permission = await Geolocator.checkPermission();
// //    if (permission == LocationPermission.denied) {
// //      permission = await Geolocator.requestPermission();
// //    }

// //    Position pos = await Geolocator.getCurrentPosition(
// //        desiredAccuracy: LocationAccuracy.high);

// //    currentLatLng = LatLng(pos.latitude, pos.longitude);

// //    drawFakeRoute();

// //    setState(() {});
// //   }

// //   /// FAKE ROUTE (NO API)
// //   void drawFakeRoute() {
// //    LatLng destination = LatLng(
// //      currentLatLng!.latitude + 0.01,
// //      currentLatLng!.longitude + 0.01,
// //    );

// //    routePoints = [
// //      currentLatLng!,
// //      LatLng(
// //        (currentLatLng!.latitude + destination.latitude) / 2,
// //        (currentLatLng!.longitude + destination.longitude) / 2,
// //      ),
// //      destination,
// //    ];
// //  }


//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<TrackingProvider>();

//   if (provider.userLocation == null) {
//     return Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }

//    return Scaffold(
//     body: Stack(
//       children: [
//         FlutterMap(
//           mapController: _mapController,
//           options: MapOptions(
//             initialCenter: provider.userLocation,
//             initialZoom: 15,
//           ),
//           children: [
//             TileLayer(
//               urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//               userAgentPackageName: 'com.example.app',
//             ),

//             //ROUTE LINE 
//             PolylineLayer(
//               polylines: [
//               Polyline(
//                 points: provider.routePoints,
//                 strokeWidth: 6,
//                 color: Colors.orange,
//               ),
//              ],
//             ),

//             //CURRENT LOCATION MARKER 
//             MarkerLayer(
//               markers: [
//                Marker(
//                 point: provider.userLocation, 
//                 width: 40,
//                 height: 40,
//                 child: Icon(Icons.my_location, color: Colors.blue, size: 35),
//                ),
//                Marker(
//                 point: provider.riderLocation!,
//                 width: 40,
//                 height: 40, 
//                 child: Icon(Icons.delivery_dining, color: Colors.red),
//                 ),
//              ],
//             ),
//           ],
//         ),

//         //TOP LEFT BUTTON 
//         Positioned(
//           top: 50,
//           left: 16,
//           child: CircleAvatar(
//             backgroundColor: Colors.white,
//             child: Icon(Icons.close),
//           ),
//         ),

//          /// TOP RIGHT BUTTONS
//          Positioned(
//            top: 50,
//            right: 16,
//            child: Column(
//              children: [
//                _circleButton(Icons.help_outline),
//                SizedBox(height: 10),
//                _circleButton(Icons.my_location),
//              ],
//            ),
//          ),

//           /// BOTTOM CARD
//          Positioned(
//            bottom: 20,
//            left: 16,
//            right: 16,
//            child: _buildBottomCard(),
//          ),

//       ],
//     ),
//    );
//   }

//   Widget _circleButton(IconData icon) {
//    return Container(
//      padding: EdgeInsets.all(10),
//      decoration: BoxDecoration(
//        color: Colors.white,
//        shape: BoxShape.circle,
//      ),
//      child: Icon(icon),
//    );
//  }

//  Widget _buildBottomCard() {
//    return Container(
//      padding: EdgeInsets.all(16),
//      decoration: BoxDecoration(
//        color: Colors.green,
//        borderRadius: BorderRadius.circular(20),
//      ),
//      child: Column(
//        mainAxisSize: MainAxisSize.min,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: [
//          Text(
//            "Preparing your order",
//            style: TextStyle(color: Colors.white, fontSize: 18),
//          ),
//          SizedBox(height: 8),
//          Text(
//            "Arrives between 11:23 PM - 12:01 AM",
//            style: TextStyle(color: Colors.white70),
//          ),
         
//          SizedBox(height: 12),

//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: [
//              Icon(Icons.store, color: Colors.white),
//              Expanded(
//               child: Divider(
//                 color: Colors.white
//                 )),
//              Icon(Icons.delivery_dining, color: Colors.white),
//              Expanded(
//               child: Divider(
//                 color: Colors.white
//                 )),
//              Icon(Icons.home, color: Colors.white),
//            ],
//          ),

//          SizedBox(height: 10),

//          Text(
//            "Your order is being prepared.",
//            style: TextStyle(color: Colors.white70),
//          ),

//          SizedBox(height: 10),
//          Center(
//            child: Text(
//              "View all details",
//              style: TextStyle(color: Colors.white),
//            ),
//          ),
//        ],
//      ),
//    );
//  }

// }




// // import 'package:flutter/material.dart';
// // import 'package:food_delivery_app/presentation/providers/tracking_provider.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:provider/provider.dart';

// // class OrderTrackingScreen extends StatefulWidget {
// //   final String orderId;

// //   const OrderTrackingScreen({super.key, required this.orderId});

// //   @override
// //   State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
// // }

// // class _OrderTrackingScreenState extends State<OrderTrackingScreen> {

// //   @override
// //   void initState() {
// //     super.initState();

// //     /// start tracking AFTER build
// //     Future.microtask(() {
// //       context.read<TrackingProvider>().startTracking(widget.orderId);
// //     });
// //   }
  
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //      body: Consumer<TrackingProvider>(
// //         builder: (context, provider, child) {

// //           ///  LOADING
// //           if (provider.userLocation == null) {
// //             return const Center(child: CircularProgressIndicator());
// //           }

// //           return Stack(
// //             children: [

// //               ///  GOOGLE MAP
// //               GoogleMap(
// //                 initialCameraPosition: CameraPosition(
// //                   target: provider.userLocation!,
// //                   zoom: 14,
// //                 ),
// //                 onMapCreated: (controller) {
// //                   provider.mapController = controller;
// //                 },
// //                 markers: provider.markers,
// //                 polylines: provider.polylines,
// //                 myLocationEnabled: true,
// //                 zoomControlsEnabled: false,
// //               ),

// //               ///  BACK BUTTON
// //               Positioned(
// //                 top: 50,
// //                 left: 16,
// //                 child: _circleButton(Icons.arrow_back, () {
// //                   Navigator.pop(context);
// //                 }),
// //               ),

// //               ///  RIGHT BUTTONS
// //               Positioned(
// //                 top: 50,
// //                 right: 16,
// //                 child: Column(
// //                   children: [
// //                     _circleButton(Icons.help_outline, () {}),
// //                     const SizedBox(height: 10),
// //                     _circleButton(Icons.my_location, () {
// //                       if (provider.userLocation != null) {
// //                         provider.mapController?.animateCamera(
// //                           CameraUpdate.newLatLng(provider.userLocation!),
// //                         );
// //                       }
// //                     }),
// //                   ],
// //                 ),
// //               ),

// //               ///  BOTTOM CARD 
// //               Positioned(
// //                 bottom: 20,
// //                 left: 16,
// //                 right: 16,
// //                 child: _buildBottomCard(),
// //               ),
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   /// 🔘 CIRCLE BUTTON
// //   Widget _circleButton(IconData icon, VoidCallback onTap) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.all(10),
// //         decoration: const BoxDecoration(
// //           color: Colors.white,
// //           shape: BoxShape.circle,
// //         ),
// //         child: Icon(icon),
// //       ),
// //     );
// //   }

// //  Widget _buildBottomCard() {
// //   return Container(
// //     padding: const EdgeInsets.all(16),
// //     decoration: BoxDecoration(
// //       color: Colors.green,
// //       borderRadius: BorderRadius.circular(20),
// //       boxShadow: [
// //         BoxShadow(
// //           color: Colors.black12,
// //           blurRadius: 10,
// //           offset: Offset(0, 5),
// //         )
// //       ],
// //     ),
// //     child: Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [

// //         Text(
// //           "Preparing your order",
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),

// //         SizedBox(height: 6),

// //         Text(
// //           "Arrives in 20-30 mins",
// //           style: TextStyle(color: Colors.white70),
// //         ),

// //         SizedBox(height: 12),

// //         /// Progress UI
// //         Row(
// //           children: [
// //             _step(Icons.store, true),
// //             _line(),
// //             _step(Icons.delivery_dining, false),
// //             _line(),
// //             _step(Icons.home, false),
// //           ],
// //         ),

// //         SizedBox(height: 12),

// //         Text(
// //           "Your food is being prepared 👨‍🍳",
// //           style: TextStyle(color: Colors.white70),
// //         ),

// //         SizedBox(height: 10),

// //         Center(
// //           child: Text(
// //             "View all details",
// //             style: TextStyle(
// //               color: Colors.white,
// //               decoration: TextDecoration.underline,
// //             ),
// //           ),
// //         ),
// //       ],
// //     ),
// //   );
// // }

// // Widget _step(IconData icon, bool active) {
// //   return CircleAvatar(
// //     radius: 14,
// //     backgroundColor: active ? Colors.white : Colors.white38,
// //     child: Icon(icon, size: 16, color: Colors.green),
// //   );
// // }

// // Widget _line() {
// //   return Expanded(
// //     child: Container(
// //       height: 2,
// //       color: Colors.white38,
// //     ),
// //   );
// // }
// // }