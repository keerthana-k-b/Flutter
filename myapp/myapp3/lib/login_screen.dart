// import 'package:flutter/material.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TabController _tabController= TabController(length: 2, vsync: this);
//   TextEditingController _firstnameController = TextEditingController();
//   TextEditingController _lastnameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _dateofbirthController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   String fname = '';
//   String lname = '';
//   String email = '';
//   String dob = '';
//   String phone = '';
//   String pswd = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Icon(Icons.shield,
//         color:Colors.blue),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: SingleChildScrollView(
//         padding:EdgeInsets.all(20),
//         child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children:[
          
//           Text(
//             "Get Started now",
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),

//           SizedBox(height: 20),

//           Text(
//             "Create an account or log in to explore about our app",
//             style: TextStyle(
//              fontSize:  20,
//              fontWeight: FontWeight.normal,
//              color: Colors.grey,
//             ),
//             ),

//             SizedBox(height: 20),

//             TabBar(
//               controller: _tabController,
//               tabs: [
//                 Tab(text: "Login"),
//                 Tab(text: "Sign Up"),
//               ]
//             ),

//             TabBarView(
//               controller: _tabController,
//               children: [
//               //login
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Email"
//                       ),
                      
//                     ),
//                     TextFormField(
//                     decoration: InputDecoration(
//                         labelText: "Password"
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(onPressed: null,
//                      child: Text("Login"),),


//                   ],
//                 ),
//               ),

//               //sign up
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text("First Name"),
//                         Text("LAst Name"),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         TextFormField(
//                           controller: _firstnameController,
//                           keyboardType: TextInputType.name,
//                           decoration: InputDecoration(
//                             hintText: "Firstname",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)
//                             )
//                           ),
                          
//                         ),

//                         TextFormField(
//                           controller: _firstnameController,
//                           keyboardType: TextInputType.name,
//                           decoration: InputDecoration(
//                             hintText: "Lastname",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                           ),
                          
//                         ),
//                         TextFormField(
//                           controller: _firstnameController,
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             hintText: "Email",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                           ),
                          
//                         ),
//                          TextFormField(
//                           controller: _firstnameController,
//                           keyboardType: TextInputType.datetime,
//                           decoration: InputDecoration(
//                             hintText: "date",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                             prefixIcon: Icon(Icons.calendar_month)
//                           ),
                          
//                         ),

                        

//  TextFormField(
//                           controller: _firstnameController,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             hintText: "+91 6785940392",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                           ),
                          
//                         ),
//                     TextFormField(
//                           controller: _firstnameController,
//                           keyboardType: TextInputType.visiblePassword,
//                           decoration: InputDecoration(
//                             hintText: "password",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20)
//                             ),
//                           ),
                          
//                         ),
//                     ElevatedButton(onPressed: null,
//                      child: Text("Register"),),


//                   ],
//                 ),
//               ),


//             ])



//         ],

//         ), 
//       ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:myapp3/profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dateofbirthController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.shield, color: Colors.blue),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              "Get Started now",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              "Create an account or log in to explore our app",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            SizedBox(height: 20),

            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: "Login"),
                Tab(text: "Sign Up"),
              ],
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [

                  /// LOGIN
                  Column(
                    children: [

                       TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder( borderRadius: BorderRadius.circular(20)),
                          ),
                        ),

                        SizedBox(height: 30),

                       TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder( borderRadius: BorderRadius.circular(20)),
                          ),
                        ),

                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {},
                        child: Text("Login"),
                      ),
                    ],
                  ),

                  /// SIGN UP
                  SingleChildScrollView(
                    child: Column(
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child: TextFormField(
                                controller: _firstnameController,
                                decoration: InputDecoration(
                                  hintText: "First Name",
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),

                            SizedBox(width: 10),

                            Expanded(
                              child: TextFormField(
                                controller: _lastnameController,
                                decoration: InputDecoration(
                                  hintText: "Last Name",
                                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder( borderRadius: BorderRadius.circular(20)),
                          ),
                        ),

                        SizedBox(height: 10),

                        TextFormField(
                          controller: _dateofbirthController,
                          decoration: InputDecoration(
                            hintText: "Date of Birth",
                            prefixIcon: Icon(Icons.calendar_month),
                            border: OutlineInputBorder( borderRadius: BorderRadius.circular(20)),
                          ),
                        ),

                        SizedBox(height: 10),

                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            hintText: "+91 Phone",
                            border: OutlineInputBorder( borderRadius: BorderRadius.circular(20)),
                          ),
                        ),

                        SizedBox(height: 10),

                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder( borderRadius: BorderRadius.circular(20)),
                          ),
                        ),

                        SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => ProfileScreen(
                          name:_firstnameController.text,
                          lname:_lastnameController.text,
                          email:_emailController.text,
                          dob: _dateofbirthController.text,
                          phone:_phoneController.text,
                          pswd:_passwordController.text,
                          )));
                          },
                          child: Text("Register"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}