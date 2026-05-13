import 'package:flutter/material.dart';
import 'package:food_delivery_app2/data/models/food_model.dart';
import 'package:food_delivery_app2/presentation/provider/food_provider.dart';
import 'package:food_delivery_app2/presentation/screens/home_screen.dart';
import 'package:food_delivery_app2/presentation/screens/product_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
    SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String query = "";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FoodProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

                SizedBox(height: 10),

              /// TOP BAR
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_)=> HomeScreen())),
                  ),
                  Expanded(
                    child: Text(
                      "Search",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              //  SEARCH BOX
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 5),
                  ],
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search your favorite food...",
                    hintStyle: GoogleFonts.poppins(),
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),

                SizedBox(height: 20),

              //  RESULTS
              Expanded(
                child: query.isEmpty
                    ? Center(
                        child: Text(
                          "Start searching ",
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : StreamBuilder<List<FoodModel>>(
                        stream: provider.searchFoods(query),
                        builder: (context, snapshot) {

                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          final foods = snapshot.data!;

                          if (foods.isEmpty) {
                            return Center(
                              child: Text(
                                "No results found ",
                                style: GoogleFonts.poppins(),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: foods.length,
                            itemBuilder: (context, index) {
                              final food = foods[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ProductDetailScreen(food: food),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12, blurRadius: 5)
                                    ],
                                  ),
                                  child: Row(
                                    children: [

                                      /// IMAGE
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        child: Image.network(
                                          food.image,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                        SizedBox(width: 15),

                                      /// TEXT
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              food.title,
                                              maxLines: 1,          
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                             SizedBox(height: 5),
                                            Text(
                                              "₹${food.price}",
                                              style: GoogleFonts.poppins(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      ///  BUTTON
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}