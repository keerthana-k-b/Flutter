import 'package:employeemanagement/provider/employee_provider.dart';
import 'package:employeemanagement/screens/home_screen.dart';
import 'package:employeemanagement/screens/search_screen.dart';
import 'package:employeemanagement/screens/settings_screen.dart';
import 'package:employeemanagement/service/sharedpreferences/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int selectedIndex = 2; // Profile default
  bool isEdit = false;

TextEditingController fullNameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController genderController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController nationalityController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController postalController = TextEditingController();
TextEditingController secondEmailController = TextEditingController();
TextEditingController usernameController = TextEditingController();

void onItemTapped(int index) {
  setState(() {
    selectedIndex = index;
  });
}

 @override
void initState() {
  super.initState();

  Future.microtask(() async {
    final provider = Provider.of<EmployeeProvider>(context, listen: false);

    String? savedToken = await StorageService.getToken();

    print("SAVED TOKEN => $savedToken"); //  debug

    if (savedToken != null && savedToken.isNotEmpty) {
      provider.token = savedToken;
      await provider.fetchProfile(savedToken);
    }
  });
}
  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      HomeScreen(),
      SearchScreen(),
      Container(), // empty placeholder instead of ProfileScreen
      SettingsScreen(),
    ];

    final provider = Provider.of<EmployeeProvider>(context);

    if(provider.isLoading){
      return Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      );
    }

    final data = provider.profileData ?? {};

    String fullName = data['fullName'] ?? "";
    String email = data['email'] ?? "";
    String phone = data['phone'] ?? "";
    String gender = data['gender'] ?? "";
    String dateOfBirth = data['dateOfBirth'] ?? "";
    String nationality = data['nationality'] ?? "";
    String country = data['country'] ?? "";
    String state = data['state'] ?? "";
    String city = data['city'] ?? "";
    String address = data['address'] ?? "";
    String postalCode= data['postalCode'] ?? "";
    String password= data['password'] ?? "";
    String status = data['status'] ?? "";
    String image = data['profileImage'] ?? "";
    String secondEmail = data['secondEmail'] ?? "";
    String username = data['username'] ?? "";
    String documentType = data['documentType'] ?? "";
    String documentNumber = data['documentNumber'] ?? "";
    String documentExpiry = data['documentExpiry'] ?? "";
    String profileType = data['profileType'] ?? "";
    String docUrl = data['docUrl'] ?? "";
    String profileImageBlog = data['profileImageBlog'] ?? "";
    String document = data['document'] ?? "";

fullNameController.text = fullName;
phoneController.text = phone;
genderController.text = gender;
dobController.text = dateOfBirth;
nationalityController.text = nationality;
countryController.text = country;
stateController.text = state;
cityController.text = city;
addressController.text = address;
postalController.text = postalCode;
secondEmailController.text = secondEmail;
usernameController.text = username;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),

  bottomNavigationBar: BottomNavigationBar(
  currentIndex: selectedIndex,
  onTap: onItemTapped,
  type: BottomNavigationBarType.fixed,

  selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.grey,

  
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: "Search",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "Profile",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Settings",
    ),
  ],
),

      body: selectedIndex == 2
      ?SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: 
                       image.isNotEmpty ? NetworkImage(image) : null,
                  child: image.isEmpty
                  ? Icon(Icons.person, size: 50)
                  :null,
                ),
              ),
              Text("View and update your account details",
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.grey[700], fontSize: 13,fontWeight: FontWeight.w500)),

              SizedBox(height: 20),
              
              Text("Full Name", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: fullNameController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(fullName),
        ),
),
              
             SizedBox(height: 12),

               Text("Email",
              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                ),
                child: Text(email),
              ),
              
             SizedBox(height: 12),

               Text("Phone", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: phoneController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(phone),
        ),
),
              
             SizedBox(height: 12),

               Text("Gender", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: genderController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(gender),
        ),
),
              
             SizedBox(height: 12),

               Text("Date of Birth", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: dobController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(dateOfBirth),
        ),
),
              
             SizedBox(height: 12),

              Text("Nationality", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: nationalityController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(nationality),
        ),
),
              
             SizedBox(height: 12),

              Text("Country", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: countryController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(country),
        ),
),
              
             SizedBox(height: 12),

               Text("State", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: stateController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(state),
        ),
),
              
             SizedBox(height: 12),

             Text("City", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: cityController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(city),
        ),
),
              
             SizedBox(height: 12),

               Text("Address", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: addressController,
          maxLines: 2,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(address),
        ),
),
              
             SizedBox(height: 12),

               Text("Postal Code", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: postalController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(postalCode),
        ),
),
              
             SizedBox(height: 12),

             Text("Password",
              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                ),
                child: Text(password),
              ),
              
             SizedBox(height: 12),

              Text("Status",
              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10),
               padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
                decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                ),
                child: Text(status),
              ),
              
             SizedBox(height: 12),

              Text("Second Email", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: secondEmailController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(secondEmail.isEmpty ? "Not Available" : secondEmail),
        ),
),
             
             SizedBox(height: 12),

            Text("Username", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
Container(
  width: double.infinity,
  margin: EdgeInsets.symmetric(vertical: 10),
  padding: EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: BorderRadius.circular(12),
  ),
  child: isEdit
      ? TextField(
          controller: usernameController,
          decoration: InputDecoration(border: InputBorder.none),
        )
      : Padding(
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Text(username.isEmpty ? "Not Available" : username),
        ),
),
             
             SizedBox(height: 12),

             Text("Document Type", 
              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
               Container(
                width: double.infinity,
               margin: EdgeInsets.symmetric(vertical: 10),
               padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
               decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
               ),
               child: Text(documentType.isEmpty ? "Not Available" : documentType),
             ),
             
             SizedBox(height: 12),

             Text("Document Number", 
              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
               Container(
                width: double.infinity,
               margin: EdgeInsets.symmetric(vertical: 10),
               padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
               decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
               ),
               child: Text(documentNumber.isEmpty ? "Not Available" : documentNumber),
             ),
             
             SizedBox(height: 12),

             Text("Document Expiry", 
              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
               Container(
                width: double.infinity,
               margin: EdgeInsets.symmetric(vertical: 10),
               padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
               decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
               ),
               child: Text(documentExpiry.isEmpty ? "Not Available" : documentExpiry),
             ),
             
             SizedBox(height: 12),

             Text("Profile Type", 
              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
               Container(
                width: double.infinity,
               margin: EdgeInsets.symmetric(vertical: 10),
               padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
               decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
               ),
               child: Text(profileType.isEmpty ? "Not Available" : profileType),
             ),
             
             SizedBox(height: 12),

             Text("Document Url", 
              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
               Container(
                width: double.infinity,
               margin: EdgeInsets.symmetric(vertical: 10),
               padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
               decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
               ),
               child: Text(docUrl.isEmpty ? "Not Available" : docUrl),
             ),
             
             SizedBox(height: 12),

             Text("Profile Image Blog ", 
              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
               Container(
                width: double.infinity,
               margin: EdgeInsets.symmetric(vertical: 10),
               padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
               decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
               ),
               child: Text(profileImageBlog.isEmpty ? "Not Available" : profileImageBlog),
             ),

             SizedBox(height: 12),

             Text("Document", 
              style: TextStyle(color: Colors.grey[700], fontSize: 13)),
               Container(
                width: double.infinity,
               margin: EdgeInsets.symmetric(vertical: 10),
               padding: EdgeInsets.symmetric(horizontal: 16,vertical: 14),
               decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
               ),
               child: Text(document.isEmpty ? "Not Available" : document),
             ),

              SizedBox(height: 20),

//  Buttons Row
Row(
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () async {
  final provider = Provider.of<EmployeeProvider>(context, listen: false);

  if (isEdit) {
    print("SAVE CLICKED"); // debug

    await provider.updateProfile(
      fullName: fullNameController.text.trim(),
      phone: phoneController.text.trim(),
      gender: genderController.text.trim(),
      dateOfBirth: dobController.text.trim(),
      nationality: nationalityController.text.trim(),
      country: countryController.text.trim(),
      state: stateController.text.trim(),
      city: cityController.text.trim(),
      address: addressController.text.trim(),
      postalCode: postalController.text.trim(),
      secondEmail: secondEmailController.text.trim(),
      username: usernameController.text.trim(),
    );

    setState(() {
      isEdit = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile Updated")),
    );
  } else {
    print("EDIT MODE"); // debug
    setState(() {
      isEdit = true;
    });
  }
},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
  isEdit ? "Save" : "Edit",
  style: TextStyle(color: Colors.white),
),
      ),
    ),

    SizedBox(width: 10),

    Expanded(
      child: ElevatedButton(
        onPressed: () {
          Provider.of<EmployeeProvider>(context, listen: false)
             .logout(context);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          "Logout",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ],
),

SizedBox(height: 20),

            ],
          ),
        ),
      )
      : pages[selectedIndex],
    );
  }
}