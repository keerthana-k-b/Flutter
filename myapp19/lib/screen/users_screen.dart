import 'package:flutter/material.dart';
import 'package:myapp19/provider/album_provider.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState(){
    super.initState();

    Provider.of<AlbumProvider>(
      context,
      listen: false
    ).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Users"),
      centerTitle: true,
       backgroundColor: Colors.blue,
     ),

     body: Container(
      padding: EdgeInsets.all(10),
      child: Provider.of<AlbumProvider>(context).isLoading
      ?Center(child: CircularProgressIndicator())
      :ListView.builder(
        itemCount: Provider.of<AlbumProvider>(context).users.length,
        itemBuilder: (context,index){
          final user = Provider.of<AlbumProvider>(context).users[index];

          return Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child:Padding(padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.id.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),
                Text(user.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.email,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.phone,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.website,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.address.street,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.address.suite,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.address.city,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.address.zipcode,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.address.geo.lat,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.address.geo.lng,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.company.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.company.catchPhrase,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),

                        Text(user.company.bs,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        ),

                        SizedBox(height: 6),
              ],

            ),
            ),
          );
      }),
     ),
    );
  }
}