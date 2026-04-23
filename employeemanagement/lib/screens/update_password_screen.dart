import 'package:employeemanagement/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //password visibility
  bool isOldPasswordHidden = true;
  bool isNewPasswordHidden = true;
  bool isConfirmPasswordHidden = true; 

  //reusable fields
  Widget buildTextFeild({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? toggleVisibility,
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Color.fromARGB(255, 28, 80, 122), fontSize: 13),),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isPassword ? obscureText : false,
            decoration: InputDecoration(
              border: InputBorder.none,

              suffixIcon: isPassword
                 ? IconButton(
                  icon: Icon(
                    obscureText
                      ?Icons.visibility_off
                      :Icons.visibility,
                  ),
                  color:  Color.fromARGB(255, 37, 103, 156),
                  onPressed: toggleVisibility, 
                 )
                :null,
            ),
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SafeArea(
  child: SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        SizedBox(height: 40),

         Text(
          "Update Password",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 31, 93, 145),
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 30),

        buildTextFeild(
          label: "Old Password",
          controller: oldPasswordController,
          isPassword: true,
          obscureText: isOldPasswordHidden,
          toggleVisibility: () {
            setState(() {
              isOldPasswordHidden = !isOldPasswordHidden;
            });
          },
        ),

        buildTextFeild(
          label: "New Password",
          controller: newPasswordController,
          isPassword: true,
          obscureText: isNewPasswordHidden,
          toggleVisibility: () {
            setState(() {
              isNewPasswordHidden = !isNewPasswordHidden;
            });
          },
        ),

        buildTextFeild(
          label: "Confirm Password",
          controller: confirmPasswordController,
          isPassword: true,
          obscureText: isConfirmPasswordHidden,
          toggleVisibility: () {
            setState(() {
              isConfirmPasswordHidden = !isConfirmPasswordHidden;
            });
          },
        ),

       SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
  if (oldPasswordController.text.isEmpty ||
      newPasswordController.text.isEmpty ||
      confirmPasswordController.text.isEmpty) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("All fields are required")),
    );
    return;
  }

  if (newPasswordController.text != confirmPasswordController.text) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Passwords do not match")),
    );
    return;
  }

  final provider = Provider.of<EmployeeProvider>(context, listen: false);

  bool success = await provider.updatePassword(
    oldPassword: oldPasswordController.text.trim(),
    newPassword: newPasswordController.text.trim(),
  );

  if (!mounted) return; 

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password Updated Successfully")),
    );
    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Password Update Failed. Check old password")),
    );
  }
},
            child: const Text("Update"),
          ),
        ),
      ],
    ),
   ),
  ),
  );
  }
}