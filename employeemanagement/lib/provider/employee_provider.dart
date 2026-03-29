import 'package:employeemanagement/screens/login_screen.dart';
import 'package:employeemanagement/screens/profile_screen.dart';
import 'package:employeemanagement/service/employee_service.dart';
import 'package:employeemanagement/service/sharedpreferences/storage_service.dart';
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier{
 final EmployeeService _employeeService = EmployeeService();

 bool _isLoading = false;
 bool get isLoading => _isLoading;
 Map<String, dynamic>? profileData;
 String? token;

 Future<void> addEmployee({
  required String email,
    required String password,
    required String fullName,
    required String phone,
    required String gender,
    required DateTime dateOfBirth,
    required String nationality,
    required String country,
    required String state,
    required String city,
    required String address,
    required String postalCode,
 }) async {
  _isLoading = true;
  notifyListeners();

  bool success = await _employeeService.registerEmployee(
    email: email, 
    password: password, 
    fullName: fullName, 
    phone: phone, 
    gender: gender, 
    dateOfBirth: dateOfBirth, 
    nationality: nationality, 
    country: country, 
    state: state, 
    city: city, 
    address: address, 
    postalCode: postalCode,
    );

    _isLoading = false;
    notifyListeners();

    if(success){
      print("Registration Successfull");
    }else{
      print("Failed Registration");
    }
  }

  Future<bool> addloginEmployee(BuildContext context, {
    required String email,
    required String password,
    required String fcmToken,
  })async {
    _isLoading = true;
    notifyListeners();

    final response = await _employeeService.loginEmployee(
      email: email, 
      password: password, 
      fcmToken: fcmToken
      );

      _isLoading = false;
      notifyListeners();

      if(response != null ){
         try{
           final data = response['data'];

          token = data['accessToken'] ?? "";
          await StorageService.saveToken(token!);
        //check response structure
        print(response);

        print("Login Success");
        print("TOKEN: $token");

        Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen()),
        );
        return true;
      }catch(e){

        print(" Parsing Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Data Error")),
      );
      return false;
      }
      }else{

        print("Login Failed");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Failed")),
    );
      return false;
      }
  }

  Future<void> fetchProfile(String token) async {
    _isLoading = true;
    notifyListeners();

    final response = await _employeeService.getEmployeeProfile(token);

    if(response != null && response['data'] != null) {
      profileData = response['data'];
    }

    _isLoading= false;
    notifyListeners();
  }

Future<void> updateProfile({
  required String fullName,
  required String phone,
  required String gender,
  required String dateOfBirth,
  required String nationality,
  required String country,
  required String state,
  required String city,
  required String address,
  required String postalCode,
  required String secondEmail,
  required String username,
}) async {

  if (token == null) {
  print("TOKEN NULL");
  return;
}

  _isLoading = true;
  notifyListeners();

  final Map<String, String> body = {
    "fullName": fullName,
    "phone": phone,
    "gender": gender,
    "dateOfBirth": dateOfBirth,
    "nationality": nationality,
    "country": country,
    "state": state,
    "city": city,
    "address": address,
    "postalCode": postalCode,
    "secondEmail": secondEmail.isEmpty ? "" : secondEmail,
    "username": username.isEmpty ? "" : username,
  };

  bool success = await _employeeService.updateEmployeeProfile(
    token: token!,
    body: body,
  );

  print("BODY => $body");

  _isLoading = false;
  notifyListeners();

  if (success) {
    print("Update Success");
    await fetchProfile(token!);
  }else {
    print("Update Failed");
   }
}


  Future<void> logout(BuildContext context) async {
  token = null;
  profileData = null;

  await StorageService.saveToken(""); // clear token

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => LoginScreen()),
    (route) => false,
  );

  notifyListeners();
}

  Future<void> loadToken() async {
  token = await StorageService.getToken();
  notifyListeners();
}
   

}