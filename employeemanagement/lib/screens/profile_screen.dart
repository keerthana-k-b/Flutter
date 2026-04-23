import 'package:employeemanagement/provider/employee_provider.dart';
import 'package:employeemanagement/screens/update_password_screen.dart';
import 'package:employeemanagement/service/sharedpreferences/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEdit = false;

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = Provider.of<EmployeeProvider>(context, listen: false);
      String? token = await StorageService.getToken();

      if (token != null && token.isNotEmpty) {
        provider.token = token;
        await provider.fetchProfile(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final data = provider.profileData ?? {};
    String fullName = data['fullName'] ?? "";

    String firstLetter =
        fullName.isNotEmpty ? fullName[0].toUpperCase() : "?";

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            /// 👤 PROFILE HEADER
            Column(
              children: [
                Stack(
                  children: [

                    /// AVATAR
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.blue.shade50,
                        child: Text(
                          firstLetter,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),

                    /// EDIT BUTTON
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => isEdit = !isEdit);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isEdit ? Icons.check : Icons.edit,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Humble Hearts, Inspiring Care",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// 🔹 INFO CARDS
            _iconTile(
              icon: Icons.person_outline,
              value: data['fullName'],
              controller: fullNameController,
            ),

            _iconTile(
              icon: Icons.email_outlined,
              value: data['email'],
              isEditable: false,
            ),

            _iconTile(
              icon: Icons.phone_outlined,
              value: data['phone'],
              controller: phoneController,
            ),

            const SizedBox(height: 10),

            /// 🔐 CHANGE PASSWORD
            _iconTile(
              icon: Icons.lock_outline,
              value: "Change Password",
              isArrow: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const UpdatePasswordScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            /// 💾 SAVE BUTTON
            if (isEdit)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await provider.updateProfile(
                      fullName: fullNameController.text.trim(),
                      phone: phoneController.text.trim(),
                    );

                    setState(() => isEdit = false);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile Updated")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Save Changes"),
                ),
              ),

            const SizedBox(height: 20),

            /// 🚪 SIGN OUT (MODERN RED BOX)
            GestureDetector(
              onTap: () {
                provider.logout(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade100),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Sign out",
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 ICON TILE
  Widget _iconTile({
    required IconData icon,
    String? value,
    TextEditingController? controller,
    bool isEditable = true,
    bool isArrow = false,
    VoidCallback? onTap,
  }) {
    if (controller != null && !isEdit) {
      controller.text = value ?? "";
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 22),
            const SizedBox(width: 14),

            Expanded(
              child: isEditable && controller != null && isEdit
                  ? TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    )
                  : Text(
                      value ?? "-",
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),

            if (isArrow)
              const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}


// import 'package:employeemanagement/provider/employee_provider.dart';
// import 'package:employeemanagement/screens/update_password_screen.dart';
// import 'package:employeemanagement/service/sharedpreferences/storage_service.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
  
//   bool isEdit = false;

//   //Controllers
//   final fullNameController = TextEditingController();
//   final phoneController = TextEditingController();
//   //final genderController = TextEditingController();
//   // final dobController = TextEditingController();
//   // final nationalityController = TextEditingController();
//   // final countryController = TextEditingController();
//   // final stateController = TextEditingController();
//   // final cityController = TextEditingController();
//   // final addressController = TextEditingController();
//   // final postalController = TextEditingController();
//  // final secondEmailController = TextEditingController();
//   //final usernameController = TextEditingController();

  

//   @override
//   void initState(){
//     super.initState();

//     Future.microtask(() async {
//       final provider = Provider.of<EmployeeProvider>(context, listen: false);

//       String? savedToken = await StorageService.getToken();

//       if (savedToken != null && savedToken.isNotEmpty) {
//         provider.token = savedToken;
//         await provider.fetchProfile(savedToken);
//       }
//     });
//   }
  
//  //  REUSABLE EDITABLE FIELD
// Widget buildProfileField({
//   required String value,
//   required TextEditingController controller,
//   int maxLines = 1,
// }) {
//   if (!isEdit) controller.text = value;

//   return Container(
//     margin: const EdgeInsets.symmetric(vertical: 8),
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black12,
//           blurRadius: 8,
//           offset: Offset(0, 4),
//         )
//       ],
//     ),
//     child: isEdit
//         ? TextField(
//             controller: controller,
//             maxLines: maxLines,
//             style: TextStyle(fontSize: 16),
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: "Enter value",
//             ),
//           )
//         : Text(
//             value.isEmpty ? "Not Available" : value,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//           ),
//   );
// }

//   //  READ ONLY FIELD
//   Widget buildReadOnlyField(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
//         Container(
//           width: double.infinity,
//           margin: EdgeInsets.symmetric(vertical: 10),
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           decoration: BoxDecoration(
//             color: Colors.grey.shade200,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(value.isEmpty ? "Not Available" : value),
//         ),
//         SizedBox(height: 12),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<EmployeeProvider>(context);

//     if (provider.isLoading) {
//       return Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     final data = provider.profileData ?? {};

//     return Scaffold(
//       appBar: AppBar(title: Text("Profile")),

      

//       //  BODY
//       body: Container(
//               color: Color(0xfff5f7fb),
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//   radius: 55,
//   backgroundColor: Colors.grey.shade200,
//   backgroundImage: data['profileImage'] != null
//       ? NetworkImage(data['profileImage'])
//       : null,
//   child: data['profileImage'] == null
//       ? Icon(Icons.person, size: 50, color: Colors.grey)
//       : null,
// ),
              
//                     SizedBox(height: 20),
              
//                     // ✅ FIELDS
//                     buildProfileField(
//                         //label: "Full Name",
//                         value: data['fullName'] ?? "",
//                         controller: fullNameController),
              
//                     Container(
//   width: double.infinity,
//   margin: const EdgeInsets.symmetric(vertical: 8),
//   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(16),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black12,
//         blurRadius: 8,
//         offset: Offset(0, 4),
//       )
//     ],
//   ),
//   child: Text(
//     data['email'] ?? "Not Available",
//     style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//   ),
// ),
              
//                     buildProfileField(
//                        // label: "Phone",
//                         value: data['phone'] ?? "",
//                         controller: phoneController),
              
//                     // buildProfileField(
//                     //     label: "Gender",
//                     //     value: data['gender'] ?? "",
//                     //     controller: genderController),
              
//                     // buildProfileField(
//                     //     label: "Date of Birth",
//                     //     value: data['dateOfBirth'] ?? "",
//                     //     controller: dobController),
              
//                     // buildProfileField(
//                     //     label: "Nationality",
//                     //     value: data['nationality'] ?? "",
//                     //     controller: nationalityController),
              
//                     // buildProfileField(
//                     //     label: "Country",
//                     //     value: data['country'] ?? "",
//                     //     controller: countryController),
              
//                     // buildProfileField(
//                     //     label: "State",
//                     //     value: data['state'] ?? "",
//                     //     controller: stateController),
              
//                     // buildProfileField(
//                     //     label: "City",
//                     //     value: data['city'] ?? "",
//                     //     controller: cityController),
              
//                     // buildProfileField(
//                     //     label: "Address",
//                     //     value: data['address'] ?? "",
//                     //     controller: addressController,
//                     //     maxLines: 2),
              
//                     // buildProfileField(
//                     //     label: "Postal Code",
//                     //     value: data['postalCode'] ?? "",
//                     //     controller: postalController),
              
//                     // buildProfileField(
//                     //     label: "Second Email",
//                     //     value: data['secondEmail'] ?? "",
//                     //     controller: secondEmailController),
              
//                     // buildProfileField(
//                     //     label: "Username",
//                     //     value: data['username'] ?? "",
//                     //     controller: usernameController),
                    
//               GestureDetector(
//   onTap: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => const UpdatePasswordScreen(),
//       ),
//     );
//   },
//   child: Container(
//     width: double.infinity,
//     margin: const EdgeInsets.symmetric(vertical: 8),
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//     decoration: BoxDecoration(
//       gradient: LinearGradient(
//         colors: [Colors.blue.shade50, Colors.blue.shade100],
//       ),
//       borderRadius: BorderRadius.circular(16),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: const [
//         Text(
//           "Change Password",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//         ),
//         Icon(Icons.arrow_forward_ios, size: 16),
//       ],
//     ),
//   ),
// ),
                   
//                    // buildReadOnlyField("Status", data['status'] ?? ""),
              
//                     SizedBox(height: 20),
              
//                     //  BUTTONS
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               if (isEdit) {
//                                 await provider.updateProfile(
//                                   fullName: fullNameController.text.trim(),
//                                   phone: phoneController.text.trim(),
//                                   // gender: genderController.text.trim(),
//                                   // dateOfBirth: dobController.text.trim(),
//                                   // nationality:
//                                   //     nationalityController.text.trim(),
//                                   // country: countryController.text.trim(),
//                                   // state: stateController.text.trim(),
//                                   // city: cityController.text.trim(),
//                                   // address: addressController.text.trim(),
//                                   // postalCode: postalController.text.trim(),
//                                   // secondEmail:
//                                   //     secondEmailController.text.trim(),
//                                   // username: usernameController.text.trim(),
//                                 );
              
//                                 setState(() => isEdit = false);
              
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text("Profile Updated")),
//                                 );
//                               } else {
//                                 setState(() => isEdit = true);
//                               }
//                             },
//                              style: ElevatedButton.styleFrom(
//           padding: EdgeInsets.symmetric(vertical: 14),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14),
//           ),
//           backgroundColor: Colors.black,
//         ),
//         child: Text(
//           isEdit ? "Save Changes" : "Edit Profile",
//           style: TextStyle(fontSize: 15),
//         ),
//       ),
//     ),
//     SizedBox(width: 10),
//     Expanded(
//       child: OutlinedButton(
//         onPressed: () {
//           Provider.of<EmployeeProvider>(context, listen: false)
//               .logout(context);
//         },
//         style: OutlinedButton.styleFrom(
//           padding: EdgeInsets.symmetric(vertical: 14),
//           side: BorderSide(color: Colors.red),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14),
//           ),
//         ),
//         child: Text(
//           "Logout",
//           style: TextStyle(color: Colors.red),
//         ),
//       ),
//     ),
//   ],
// ),
//                   ],
//                 ),
//               ),
//             )
//     );
//   }
// }

