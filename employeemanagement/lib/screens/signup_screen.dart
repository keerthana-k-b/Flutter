import 'package:employeemanagement/provider/employee_provider.dart';
import 'package:employeemanagement/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
TextEditingController fullnameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneContoller = TextEditingController();
//TextEditingController genderController = TextEditingController();
TextEditingController dateOfBirthController = TextEditingController();
TextEditingController nationalityController = TextEditingController();
TextEditingController countryController = TextEditingController();
TextEditingController stateController = TextEditingController();
TextEditingController cityController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController postalCodeController = TextEditingController();
TextEditingController passwordController = TextEditingController();

 String? selectedGender;

 bool isPasswordVisible = false;


Future<void> employeeRegistration(BuildContext context) async {
  final provider = Provider.of<EmployeeProvider>(context,listen: false);
  
  try{
    await provider.addEmployee(
      email: emailController.text, 
      password: passwordController.text, 
      fullName: fullnameController.text, 
      phone: phoneContoller.text, 
      gender: selectedGender ?? "", 
      dateOfBirth: DateTime.parse(
    DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(dateOfBirthController.text)), ),
      nationality: nationalityController.text, 
      country: countryController.text, 
      state: stateController.text, 
      city: cityController.text, 
      address: addressController.text, 
      postalCode: postalCodeController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Request sent")),
    );
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Input")),
    );
  }
}

Future<void> pickDate(BuildContext context) async {
  DateTime? pickDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(), 
    firstDate: DateTime(1900), 
    lastDate: DateTime(2100),
    );

    if(pickDate != null){
      setState(() {
         //dateOfBirthController.text = "${pickDate.year}-${pickDate.month}-${pickDate.day}";

         dateOfBirthController.text =
              DateFormat('yyyy-MM-dd').format(pickDate);
      });
    }
} 

 //dateOfBirthController.text = DateFormat('dd-mm-yyyy').format(pickedDate);


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);
    return Scaffold(
      appBar: AppBar(
  toolbarHeight: 80,
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context); //  go back
    },
  ),
  title: Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: Align(
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            "assets/health_care.png",
            height: 40,
          ),
          Text(
            "HUMBLE HEARTS",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "CARE",
            style: TextStyle(color: Colors.blue, fontSize: 11),
          ),
        ],
      ),
    ),
  ),
),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sign Up",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
             ),
             Text("Create an account to continue!",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              ),
             ),
             SizedBox(height: 20),
        
             Text("FullName",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: fullnameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:"Enter full name",
                  icon: Icon(Icons.person),
                ),
              ),
             ),
        
             SizedBox(height: 10),
        
             Text("Email",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:"abc@gmail.com",
                  icon: Icon(Icons.email),
                ),
              ),
             ),
        
             SizedBox(height: 10),
        
             Text("Phone",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),

             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IntlPhoneField(
                decoration: InputDecoration(
                 border: InputBorder.none,
                 hintText: 'Phone Number',
               ),
              initialCountryCode: 'GB',
              onChanged: (phone) {
               phoneContoller.text = phone.completeNumber;
              },
            ),
           ),
        
            //  Container(
            //   margin: EdgeInsets.symmetric(vertical: 10),
            //   padding: EdgeInsets.symmetric(horizontal: 16),
            //   decoration: BoxDecoration(
            //    color: Colors.grey.shade200,
            //    borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: TextFormField(
            //     controller: phoneContoller,
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       hintText:"+447912345678",
            //       icon: Icon(Icons.phone),
            //     ),
            //   ),
            //  ),
        
             SizedBox(height: 10),
        
             Text("Gender",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
             
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Select Gender",
                  icon: Icon(Icons.wc),
                ),
                items: ["Male", "Female", "Other"].map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                )).toList(),
                  onChanged: (value){
                    setState(() {
                      selectedGender = value;
                    });
                  } 
               ),
             ),
        
             SizedBox(height: 10),
        
             Text("Date of Birth",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: dateOfBirthController,
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Select Date of Birth",
                  icon: Icon(Icons.calendar_today),
                ),
                onTap: () => pickDate(context),
              ),
             ),
        
             SizedBox(height: 10),
        
             Text("Nationality",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: nationalityController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:"British",
                  icon: Icon(Icons.flag),
                  
                ),
              ),
             ),
        
             SizedBox(height: 10),
        
             Text("Country",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: countryController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:"United Kingdom",
                  icon: Icon(Icons.public),
                ),
              ),
             ),
        
             SizedBox(height: 10),
        
             Text("State",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: stateController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your state",
                  icon: Icon(Icons.map),
                 
                ),
              ),
             ),
        
             SizedBox(height: 10),
        
             Text("City",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: cityController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your city",
                  icon: Icon(Icons.location_city),
                  
                ),
              ),
             ),
        
             SizedBox(height: 10),
        
             Text("Address",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter your full address",
                  icon: Icon(Icons.home),
                ),
              ),
             ),
        
             SizedBox(height: 10),
        
             Text("PostalCode",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
                controller: postalCodeController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:"SW1A 1AA",
                  icon: Icon(Icons.local_post_office),
                ),
              ),
             ),
        
             SizedBox(height: 10),
        
             Text("Password",
             style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
              ),
             ),
        
             Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
               color: Colors.grey.shade200,
               borderRadius: BorderRadius.circular(12),
              ),
              child: TextFormField(
              controller: passwordController,
                obscureText: !isPasswordVisible, // toggle
                decoration: InputDecoration(
                 border: InputBorder.none,
                 hintText: "Enter your password",
                 icon: Icon(Icons.lock),

              //  eye icon
                suffixIcon: IconButton(
                 icon: Icon(
                   isPasswordVisible
                    ? Icons.visibility
                     : Icons.visibility_off,
                     ),
                   onPressed: () {
                        setState(() {
                       isPasswordVisible = !isPasswordVisible;
                     });
                   },
                  ),
                ),
               ),
             ),
        
             SizedBox(height: 20),
        
             provider.isLoading
             ? CircularProgressIndicator()
             :SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () => employeeRegistration(context),
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 14),
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Text(
      "Register",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
),
        
             SizedBox(height: 20),
        
             Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("Already have an account?"),
    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      child: Text(
        "Login",
        style: TextStyle(color: Colors.blue),
      ),
    ),
  ],
),
        
        
            ],
          ),
          ),
      ),

    );
  }
}