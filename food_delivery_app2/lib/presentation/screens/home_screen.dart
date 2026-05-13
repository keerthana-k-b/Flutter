import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app2/presentation/provider/cart_provider.dart';
import 'package:food_delivery_app2/presentation/provider/food_provider.dart';
import 'package:food_delivery_app2/presentation/screens/cart_screen.dart';
import 'package:food_delivery_app2/presentation/screens/product_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int notificationCount = 0;
  @override
  void initState(){
    super.initState();
     FirebaseMessaging.onMessage.listen((message) {
       print("Notification received: ${message.notification?.title}");
     setState(() {
      notificationCount++;
    });
   });
   Provider.of<CartProvider>(context, listen: false).loadCartFromFirebase();
  }

  @override
  Widget build(BuildContext context) {

    final foodProvider = Provider.of<FoodProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      
     appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  leading: Icon(Icons.menu, color: Colors.black),

  actions: [
    Stack(
      children: [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartScreen()),
            );
          },
        ),

        // CART BADGE
        if (notificationCount > 0)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                "$notificationCount",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ),
      ],
    ),
  ],
),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                SizedBox(height: 20),
          
                Center(
                  child: Image.asset(
                    "assets/pizza.png",
                    height: 150,
                  ),
                ),
          
                SizedBox(height: 20),
          
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(text: 'A'),
                    TextSpan(
                      text: ' special dish',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                   TextSpan(text: '\nprepared for you'),
                  ],
                 ),
                ),
          
                Text(
                  "Our food delivery app begins your\nfavourite dishes to you.",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.grey),
                ),
          
                SizedBox(height: 20),
          
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foodProvider.categories.length,
                    itemBuilder: (context, index) {
                      final cat = foodProvider.categories[index];
                      return _categoryItem(
                        icon: cat["icon"],
                        title: cat["name"],
                        active: foodProvider.selectedIndex == index,
                        onTap: () => foodProvider.selectCategory(index),
                      );
                    },
                  ),
                ),
          
               SizedBox(height: 20),
          
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                      "Popular Foods",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
          
                    Text(
                      "0/18",
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                 ],
               ),
          
               SizedBox(height: 15),
           
               SizedBox(
                  height: 160,
                  child: StreamBuilder(
                    stream: foodProvider.foodsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                         return Center(child: CircularProgressIndicator());
                      }
          
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                         return  Center(child: Text("No foods found"));
                      }
          
                      final foods = snapshot.data!;
          
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: foods.length,
                        itemBuilder: (context, index) {
                          final food = foods[index];
                          return Container(
                            width: 160,
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 6)
                              ],
                            ),
                            
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailScreen(food: food,),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16)
                                    ),
                                    child: Image.network(
                                      food.image,
                                      height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                        
                                  SizedBox(height: 8),
                                        
                                  Text(
                                    food.title,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                        
                                  Text(
                                    "${food.price}",
                                    style: GoogleFonts.poppins(color: Colors.grey),
                                  )

                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // CATEGORY WIDGET
  Widget _categoryItem({
    required IconData icon,
    required String title,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:  EdgeInsets.only(right: 15),
        padding:  EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: active ? Colors.orange : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow:  [
            BoxShadow(color: Colors.black12, blurRadius: 5)
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: active ? Colors.white : Colors.black),
            SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                color: active ? Colors.white : Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

}