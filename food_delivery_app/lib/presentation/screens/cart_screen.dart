import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/services/cart_service.dart';
import 'package:food_delivery_app/data/services/order_service.dart';
import 'package:food_delivery_app/presentation/providers/cart_provider.dart';
import 'package:food_delivery_app/presentation/screens/order_history_screen.dart';
import 'package:food_delivery_app/presentation/screens/order_tracking_mock_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartProvider>(context);
    final cartService = CartService();

    

    return Scaffold(
      appBar: AppBar(
  title: Text("Cart"),
  centerTitle: true,
  actions: [
    IconButton(
      icon: Icon(Icons.history),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderHistoryScreen(),
          ),
        );
      },
    )
  ],
),

      body: cart.items.isEmpty
           ?Center(child: Text("Cart is empty"))
           :Column(
             children: [

              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (context, index){
                    final item = cart.items[index];

                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [

                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.food.image,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),

                            SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.food.title,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    Text("₹${item.food.price}")
                                  ],
                                ),
                              ),

                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => cart.decreaseQty(index), 
                                   icon: Icon(Icons.remove),
                                  ),

                                  Text(item.quantity.toString()),

                                  IconButton(
                                    onPressed: () => cart.increaseQty(index), 
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                           ),
                         ),
                       );
                     }
                   ), 
                 ),


             Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ],
              ),

              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total:",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "₹${cart.totalAmount.toStringAsFixed(2)}",
                        style: GoogleFonts.poppins( 
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(onPressed: () async {

                      final orderService = OrderService();

                      final orderId = await orderService.createOrder(
                       userLat: 10.0, // later use real location
                       userLng: 76.0,
                       items: cart.items.map((e) => {
                         "title": e.food.title,
                         "price": e.food.price,
                         "qty": e.quantity,
                        }).toList(),
                        total: cart.totalAmount,
                        );

                       cart.clearCart();

                      
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Order Placed")),
                       );

                      
                        Navigator.push(
                           context,
                          MaterialPageRoute(
                          builder: (_) => OrderTrackingMockPage(orderId: orderId),
                         ),
                        );
                     },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text("Checkout"),
                   ),
                 ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}