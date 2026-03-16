import 'package:flutter/material.dart';
import 'package:myapp18/model/users_model.dart';
import 'package:myapp18/service/users_service.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {

  final UsersService _service = UsersService();

  late Future<List<UsersModel>> _users;

  @override
  void initState(){
    super.initState();

    _users =_service.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "API Users",
        ),
        centerTitle: true,
      ),

      body: FutureBuilder<List<UsersModel>>(
        future: _users, 
        builder: (context,snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.hasError){
            return Center(
              child: Text(
                "Error loading data"
              ),
            );
          }

          final users = snapshot.data!;

          return MasonryGridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            mainAxisSpacing: 10,
            crossAxisSpacing:10,
            itemCount: users.length,
            itemBuilder: (context,index){

              final user = users[index];

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.id.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        user.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        user.username,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        user.email,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        user.address.street,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      Text(
                        user.address.suite,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      
                      Text(
                        user.address.city,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      
                      Text(
                        user.address.zipcode,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      
                      Text(
                        user.address.geo.lat,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      Text(
                        user.address.geo.lng,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        user.phone,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        user.website,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        user.company.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),

                      Text(
                        user.company.catchPhrase,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      
                      Text(
                        user.company.bs,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }
          );
        },
      ),
    );
  }
}