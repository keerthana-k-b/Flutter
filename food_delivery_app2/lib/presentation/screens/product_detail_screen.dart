import 'package:flutter/material.dart';
import 'package:food_delivery_app2/data/models/food_model.dart';
import 'package:food_delivery_app2/presentation/provider/cart_provider.dart';
import 'package:food_delivery_app2/presentation/screens/cart_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final FoodModel food;

  const ProductDetailScreen({super.key, required this.food});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final food = widget.food;

    return Scaffold(
      backgroundColor:  Color(0xFFFFC857),

      body: Column(
        children: [
      
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                color: Color(0xFFFFC857),
              ),
      
              Positioned(
                top: 40,
                left: 10,
                child: IconButton(
                  onPressed:() => Navigator.pop(context), 
                  icon: Icon(Icons.arrow_back),
                ),
              ),
      
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Image.network(
                    food.image,
                    height: 180,
                  ),
                ),
              ),
            ],
          ),
      
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
      
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            food.title,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₹${food.price}",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
      
                      SizedBox(height: 10),
      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _InfoItem("10 min", Icons.timer),
                          _InfoItem("2k+", Icons.reviews),
                          _InfoItem("4.6", Icons.star),
      
                        ],
                      ),
      
                      SizedBox(height: 20),
      
                      Text(
                        "Description",
                        style: GoogleFonts.poppins(fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                      ),
      
                      SizedBox(height: 5),
      
                      Text(
                        food.description,
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ),
      
                      Spacer(),
      
                      Row(
                       children: [
      
                       Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: Row(
                          children: [
      
                            IconButton(
                              onPressed: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                              icon:  Icon(Icons.remove),
                            ),
      
                            Text(
                              quantity.toString(),
                              style:  TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
      
                            IconButton(
                              onPressed: () {
                                setState(() => quantity++);
                              },
                              icon:  Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
      
                      SizedBox(width: 20),
      
                      
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final cart = context.read<CartProvider>();
      
                            for (int i = 0; i < quantity; i++) {
                              cart.addToCart(food);
                            }
      
                            ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(
                                content: Text("Added to cart"),
                              ),
                              
                            );
                            Navigator.push(
                               context,
                               MaterialPageRoute(builder: (_) => CartScreen()),
                           );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding:  EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child:  Text("Add to cart"),
                        ),
                      )
      
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// SMALL INFO WIDGET
 class _InfoItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const _InfoItem(this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
 }

