
import 'package:flutter/material.dart';
import 'package:myapp11/home_screen.dart';
import 'package:myapp11/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  String name = '';
  String email = '';
  String dob = '';
  String phone = '';
  String address = '';
  String password = '';

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString('name') ?? '';  //data from signup page that key is used here
      email = prefs.getString('email') ?? '';
      dob = prefs.getString('dob') ?? '';
      phone = prefs.getString('phone') ?? '';
      address = prefs.getString('address') ?? '';
      password = prefs.getString('pswd') ?? '';

    });
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLogin',false);

    Navigator.pushAndRemoveUntil(
      context, 
      MaterialPageRoute(builder: (context)=>LoginScreen()),
       (route)=>false,
    );
  }

  @override

  void initState() {
  super.initState();
  getData();
}



int currentIndex = 1;

  List pages = [
    HomeScreen(),
    null,
    Center(child: Text("Edit Page")),
  ];

  bool isDark = false;

  @override
  Widget build(BuildContext context) {

    pages[1] = profileUI();   // current profile page

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,

      appBar: AppBar(
        backgroundColor: isDark ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : Colors.black,
        ),
        title: Row(
          children: [
            Image.asset("assets/butterfly.png", height: 30),
            SizedBox(width: 20),

            Text(
              "My Profile",
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            Spacer(),

            IconButton(
              icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                setState(() {
                  isDark = !isDark;
                });
              },
            )
          ],
        ),
      ),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: isDark ? Colors.black : Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: isDark ? Colors.white : Colors.black,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: "Edit",
          ),
        ],
      ),
    );
  }

  Widget profileUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            CircleAvatar(
              radius: 40,
              backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
              child: ClipOval(
                child: Image.asset(
                  "assets/profile.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 20),

            profileBox("Name", name),
            SizedBox(height: 20),

            profileBox("Email", email),
            SizedBox(height: 20),

            profileBox("Date of Birth", dob),
            SizedBox(height: 20),

            profileBox("Phone number", phone),
            SizedBox(height: 20),

            profileBox("Address", address),
            SizedBox(height: 20),

            profileBox("Password", "********"),

            SizedBox(height: 20),

                   Container(
                    width: 250,
                    height: 30,
                    child: ElevatedButton(onPressed: logout,
                    //(){
                      // Navigator.push(
                      //   context,
                      //    MaterialPageRoute(builder: (context)=>ProfileScreen()),);
                    //},
                    
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ), 
                    
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        
                      ),
                    ),
                   ),
                 ),
          ],
        ),
      ),
    );
  }

  Widget profileBox(title, value) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? Colors.black54 : Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(
            title + ": ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//   int currentIndex = 0;

//   List pages = [
//     HomeScreen(),
//     ProfileScreen(),
//   ];

//   bool isDark = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: isDark ? Colors.black : Colors.white,
//       appBar: AppBar(
//         backgroundColor: isDark ? Colors.black : Colors.white,
//         iconTheme: IconThemeData(
//         color: isDark ? Colors.white : Colors.black,
//         ),
//         title: Row(
//           children: [
//             Image.asset("assets/butterfly.png",
//             height: 30,
//             ),
//             SizedBox(width: 20),

//             Text("My Profile",
//             style: TextStyle(
//             color: isDark ? Colors.white : Colors.black,
//               ),
//            ),

//             //SizedBox(width: 20),
//             Spacer(),

//             IconButton(icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode), 
//             onPressed: (){
//               setState(() {
//                 isDark = !isDark;
//               });
//             },)
//           ],
//         ),
//       ),
      

//      bottomNavigationBar: BottomNavigationBar(
//       type: BottomNavigationBarType.fixed,
//       backgroundColor: isDark ? Colors.black : Colors.white,
//       selectedItemColor: Colors.deepPurple,
//       unselectedItemColor: isDark ? Colors.white : Colors.black,
//       currentIndex: currentIndex,
//      onTap:(index){
//       setState(() {
//         currentIndex = index;
//       });
//      },
//      items: [
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home),
//       label: "Home",
//       ),

//       BottomNavigationBarItem(
//         icon: Icon(Icons.person),
//       label: "Profile",
//       ),

//       BottomNavigationBarItem(
//         icon: Icon(Icons.update),
//       label: "Edit",
//       ),

//      ],
//      ),

//       body:SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: Column(
//               children: [
                
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
//                   child: ClipOval(
//                     child: Image.asset(
//                        "assets/profile.png",
//                         fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 20),

//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: isDark ? Colors.black54 : Colors.white,
//                     border: Border.all(
//                       color: Colors.grey,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Text("Name: ",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: isDark ? Colors.white :Colors.black,
//                       ),
//                     ),
//                     Text(name,
//                     style: TextStyle(
//                       color: isDark ? Colors.white :Colors.black,
//                     ),),
//                     ],
//                   ),
//                 ),

//                     SizedBox(height: 20),
                
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: isDark ? Colors.black54 : Colors.white,
//                     border: Border.all(
//                       color: Colors.grey
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Text("Email: ",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: isDark ? Colors.white :Colors.black,
//                       ),
//                     ),
//                     Text(email,
//                     style: TextStyle(
//                       color: isDark ? Colors.white :Colors.black,
//                     ),),
//                     ],
//                   ),
//                 ),

//                     SizedBox(height: 20),
                
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: isDark ? Colors.black54 : Colors.white,
//                     border: Border.all(
//                       color: Colors.grey
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Text("Date of Birth: ",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: isDark ? Colors.white :Colors.black,
//                       ),
//                     ),
//                     Text(dob,
//                     style: TextStyle(
//                       color: isDark ? Colors.white :Colors.black,
//                     ),),
//                     ],
//                   ),
//                 ),

//                     SizedBox(height: 20),
                
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: isDark ? Colors.black54 : Colors.white,
//                     border: Border.all(
//                       color: Colors.grey
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Text("Phone number: ",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: isDark ? Colors.white :Colors.black,
//                       ),
//                     ),
//                     Text(phone,
//                     style: TextStyle(
//                       color: isDark ? Colors.white :Colors.black,
//                     ),),
//                   ],
//                   ),
//                 ),

//                     SizedBox(height: 20),
                
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: isDark ? Colors.black54 : Colors.white,
//                     border: Border.all(
//                       color: Colors.grey
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Text("Address: ",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: isDark ? Colors.white :Colors.black,
//                       ),
//                     ),
//                     Text(address,
//                     style: TextStyle(
//                       color: isDark ? Colors.white :Colors.black,
//                     ),),
//                     ],
//                   ),
//                 ),

//                     SizedBox(height: 20),
                
//                 Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: isDark ? Colors.black54 : Colors.white,
//                     border: Border.all(
//                       color: Colors.grey
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Row(
//                     children: [
//                       Text("Password: ",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: isDark ? Colors.white :Colors.black,
//                       ),
//                     ),
//                     Text(password,
//                     style: TextStyle(
//                       color: isDark ? Colors.white :Colors.black,
//                     ),),
//                     ],
//                   ),
//                 ),
//               ],

//             ),
//           ),
//         ),
//     );
//   }
// }