import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app2/data/services/auth_service.dart';
import 'package:food_delivery_app2/presentation/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    if(user == null) {
      return Scaffold(
        body: Center(child: Text("User not logged in")),
      );
    }

    return Scaffold(
       backgroundColor:  Color(0xFFF8F8F8),

       body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),

              Row(
                children: [
                  IconButton(onPressed: () => Navigator.pop(context), 
                  icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Profile",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              Expanded(
                child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                        .collection('user')
                        .doc(user.uid)
                        .snapshots(), 
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.data() == null) {
                        return Center(child: Text("No user data found"));
                      }

                      final data = snapshot.data!.data() as Map<String, dynamic>;

                      return SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      
         Center(
  child: Column(
    children: [
      CircleAvatar(
        radius: 40,
        backgroundColor: Colors.white,
        child: Icon(Icons.person, size: 40, color: Colors.orange),
      ),
    ],
  ),
),
     

      const SizedBox(height: 25),

      //  SECTION TITLE
      Text(
        "Account Info",
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

       SizedBox(height: 15),

      /// EMAIL
      _infoTile(Icons.email, "Email", data['email']),

      /// PHONE
      _infoTile(Icons.phone, "Phone", data['phone']),

      /// ADDRESS
      _infoTile(Icons.location_on, "Address", data['address']),

      const SizedBox(height: 30),

      // LOGOUT BUTTON
      ElevatedButton.icon(
        onPressed: () async {
          await _authService.logout();
          Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(builder: (_) => LoginScreen()),
             (route) => false, 
           );
        },
        icon: Icon(Icons.logout),
        label: Text("Logout"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          minimumSize: Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ],
  ),
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

   Widget _infoTile(IconData icon, String title, String value) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 5)
      ],
    ),
    child: Row(
      children: [

        /// ICON
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.orange),
        ),

        SizedBox(width: 15),

        /// TEXT
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 5),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
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