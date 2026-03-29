import 'package:flutter/material.dart';
import 'package:myapp22/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController cpuController = TextEditingController();
  final TextEditingController diskController = TextEditingController();

  void submitProduct(BuildContext context){
    final provider = Provider.of<ProductProvider>(context,listen: false);

    try{
      provider.addProduct(
        name: nameController.text, 
        year: int.parse(yearController.text), 
        price: double.parse(priceController.text), 
        cpu: cpuController.text, 
        disk: diskController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Request Sent")),
        );
        Navigator.pop(context);  // go back to View screen

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid Input"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Product"
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name"
              ),
            ),
            TextField(
              controller: yearController,
              decoration: InputDecoration(
                labelText: "Year"
              ),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: "Price"
              ),
            ),
            TextField(
              controller: cpuController,
              decoration: InputDecoration(
                labelText: "CPU Model"
              ),
            ),
            TextField(
              controller: diskController,
              decoration: InputDecoration(
                labelText: "Disk Size"
              ),
            ),

            SizedBox(height: 20),

            provider.isLoading
              ?CircularProgressIndicator()
              :ElevatedButton(onPressed: ()=>submitProduct(context), 
              child: Text(
                "Submit"
              ),
            ),
          ],
        ),
      ),

    );
  }
}