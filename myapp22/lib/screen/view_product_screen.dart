import 'package:flutter/material.dart';
import 'package:myapp22/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({super.key});

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {

  String? editingId;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController cpuController = TextEditingController();
  final TextEditingController diskController = TextEditingController();

  @override
  void initState(){
    super.initState();

    Future.microtask((){
    Provider.of<ProductProvider>(context,listen: false).getProducts();
    });
  }


  void submitProduct() async{
    final provider = Provider.of<ProductProvider>(context,listen: false);

    try{
      await provider.addProduct(
        name: nameController.text, 
        year: int.parse(yearController.text), 
        price: double.parse(priceController.text), 
        cpu: cpuController.text, 
        disk: diskController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Request Sent")),
        );
        
        //clear fields
        nameController.clear();
        yearController.clear();
        priceController.clear();
        cpuController.clear();
        diskController.clear();

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid Input"))
      );
    }
  }

  void updateProduct(BuildContext context,String id) async{
    final provider = Provider.of<ProductProvider>(context,listen: false);
     try{
      await provider.updateProduct(
        id: id, 
        name: nameController.text, 
        year: int.parse(yearController.text), 
        price: double.parse(priceController.text), 
        cpu: cpuController.text, 
        disk: diskController.text, color: 'black', 
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Update Request Sent")),
        );
     }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid Input")),
      );
     }
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
      resizeToAvoidBottomInset: true,
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
     

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.deepPurple,Colors.pinkAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
             left: 12,
             right: 12,
             top: 12,
             bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              children: [
                //form section
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                      controller: nameController,
                       decoration: InputDecoration(
                       prefixIcon: Icon(Icons.shopping_bag),
                       labelText: "Product Name",
                         filled: true,
                         fillColor: Colors.grey[100],
                           border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                       ),
                     ),
                    ),
                    SizedBox(height: 10),
                              
                Container(
                  decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                  child: TextField(
                    controller: yearController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: "Year",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      )
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                              
                SizedBox(height: 10),
                              
                Container(
                  decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.currency_rupee),
                       labelText: "Price",
                         filled: true,
                         fillColor: Colors.grey[100],
                           border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                              
                SizedBox(height: 10),
                              
                Container(
                  decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                  child: TextField(
                    controller: cpuController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.memory),
                       labelText: "CPU Model",
                         filled: true,
                         fillColor: Colors.grey[100],
                           border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                    ),
                  ),
                ),
                              
                SizedBox(height: 10),
                              
                Container(
                  decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                  child: TextField(
                    controller: diskController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.storage),
                       labelText: "Disk Size",
                         filled: true,
                         fillColor: Colors.grey[100],
                           border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                    ),
                  ),
                ),
                      
                SizedBox(height: 20),
                      
                provider.isLoading
                  ?CircularProgressIndicator()
                  :ElevatedButton(
                    style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          //foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 40,vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                              
                  onPressed: () async {
                  if (editingId == null) {
                    submitProduct();
                  } else {
                     updateProduct(context, editingId!);
                      
                      // ✅ clear form after update
                      nameController.clear();
                      yearController.clear();
                      priceController.clear();
                      cpuController.clear();
                      diskController.clear();
                      
                      setState(() {
                        editingId = null;
                      });
                              }
                        },
                        child: Text(editingId == null ? "Add Product" : "Update Product",
                        style: TextStyle(fontSize: 16,
                        color: Colors.white),
                        ),
                              
                        
                      )
                  ],
                ),
                
            SizedBox(height: 20),
            Divider(),
            
            
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
                    setState(() {
                       editingId = product.id;
                    });
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
        ),
      ),
      
    );
  }
}