import 'dart:convert';

import 'package:http/http.dart' as http;

class EmployeeService {
  static String baseUrl = "https://api.bigmonks.com/";
  static String registerUrl = "student/auth/register";
  static String loginUrl = "student/auth/login";
  static String profileUrl = "student/details/get";
  static String updateProfileUrl = "student/details/update";

  Future<bool> registerEmployee({
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
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(baseUrl + registerUrl),
      );

      // ✅ Add fields (form-data)
      request.fields.addAll({
        "email": email,
        "password": password,
        "fullName": fullName,
        "phone": phone,
        "gender": gender,
        "dateOfBirth": dateOfBirth.toIso8601String().split('T')[0],
        "nationality": nationality,
        "country": country,
        "state": state,
        "city": city,
        "address": address,
        "postalCode": postalCode,
      });

      print("REQUEST BODY: ${request.fields}");

      // Send request
      var response = await request.send();

      // Convert response to string
      var responseData = await response.stream.bytesToString();

      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE: $responseData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>?> loginEmployee({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try{
      final body = {
        "email" : email,
        "password": password,
        "fcmToken":fcmToken,
      };
    
    final response = await http.post(Uri.parse("$baseUrl$loginUrl"),
    headers: {
      "Content-Type":"application/json"
    },
    body: jsonEncode(body),
    );
    
    print("RESPONSE: ${response.body}");

    if(response.statusCode == 200 || response.statusCode == 201){
      
      //print("Success: $response.body");
      return jsonDecode(response.body);  //return full response
    }else{
      //print("Error: $response.body");
      return null;
    }
    }catch(e){
      print("Exception: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getEmployeeProfile(String token) async{
   try{
    final response = await http.get(Uri.parse("$baseUrl$profileUrl"),
    headers: {
      "Authorization":"Bearer $token",
     },
    );

    print("Profile Status: ${response.statusCode}");
    print("Profile Response: ${response.body}");

    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      return null;
    }
   }catch(e) {
    print("Profile Error: $e");
    return null;
   }
  }

Future<bool> updateEmployeeProfile({
  required String token,
  required Map<String, String> body,
}) async {

  var request = http.MultipartRequest(
    'PUT', 
    Uri.parse("$baseUrl$updateProfileUrl"),
  );

  // headers
  request.headers['Authorization'] = "Bearer $token";

  // fields
  request.fields.addAll(body);

  print("TOKEN => $token");
  print("BODY => ${request.fields}");

  var response = await request.send();

  var responseData = await response.stream.bytesToString();

  print("STATUS => ${response.statusCode}");
  print("RESPONSE => $responseData");

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

}