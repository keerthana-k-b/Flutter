import 'package:flutter/material.dart';
import 'package:myapp22/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController cpuController = TextEditingController();
  final TextEditingController diskController = TextEditingController();

 @override
 void initState(){
  super.initState();

  Provider.of<ProductProvider>(context,listen: false).getProducts();
 }

 void openProductBottomSheet({String? id}){
  final provider = Provider.of<ProductProvider>(context,listen: false);

  if(id == null){
    nameController.clear();
    yearController.clear();
    priceController.clear();
    cpuController.clear();
    diskController.clear();
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
     builder: (context){
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                id == null ? "Add Product" : "Update Product",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 15),

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

            ElevatedButton(
              onPressed: () async {
                try{
                  if(id == null){
                    await provider.addProduct(
                      name: nameController.text, 
                      year: int.parse(yearController.text), 
                      price: double.parse(priceController.text), 
                      cpu: cpuController.text, 
                      disk: diskController.text,
                      );
                  }else{
                    await provider.updateProduct(
                      id: id, 
                      name: nameController.text, 
                      year: int.parse(yearController.text), 
                      price: double.parse(priceController.text), 
                      cpu: cpuController.text, 
                      disk: diskController.text, 
                      color: "black",
                      );
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success")),
                  );
                  
                  
                }catch(e){
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Input")),
                 );
              }
            },
             child: Text(id == null ? "Add" : "Update"),
             )

            ],
          ),
        ),
       );
     });
 }

 void deleteProduct(BuildContext context,String id){
    final provider = Provider.of<ProductProvider>(context,listen: false);

    
    provider.deleteProduct(id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Delete Request Send")),
        );
  }

  void confirmDelete(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Delete"),
      content: const Text("Are you sure you want to delete?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            deleteProduct(context, id);
          },
          child: const Text("Delete"),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PRODUCTS",
          style: TextStyle(
           // color: Colors.purple,
            //fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            provider.isLoading
            ?Center(
              child: CircularProgressIndicator())
              :ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                itemCount: provider.products.length,
                itemBuilder: (context,index){
                  final product = provider.products[index];
                      
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Row(
                         children: [
                          CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Text(
                              product.name[0].toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 10),
                         Expanded(
                          child: Text(
                          product.name,
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          ),
                        ),
                      ),
                      
                      
                      
                // EDIT ICON
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // fill form with existing data
                    nameController.text = product.name;
                    yearController.text = product.data.year.toString();
                    priceController.text = product.data.price.toString();
                    cpuController.text = product.data.cpu;
                    diskController.text = product.data.disk;
                      
                    // call update
                    nameController.text = product.name;
                    yearController.text = product.data.year.toString();
                    priceController.text = product.data.price.toString();
                    cpuController.text = product.data.cpu;
                    diskController.text = product.data.disk;

                   openProductBottomSheet(id: product.id);
                  },
                ),

                //Delete Icon

                     IconButton(
                        icon: Icon(Icons.delete, color:Colors.red),
                        onPressed:() => confirmDelete(context, product.id),
                      ),
              ],
            ),
            Divider(),
                        Text("ID: ${product.id}"),
                        Text("Year: ${product.data.year}"),
                        Text("Price: ${product.data.price}"),
                        Text("CPU: ${product.data.cpu}"),
                        Text("Disk: ${product.data.disk}"),
                      ],
                    ),
                    ),
                  );
                }),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: (){
        openProductBottomSheet();
      }),
      
    );
  }
}