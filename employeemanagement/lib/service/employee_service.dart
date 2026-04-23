import 'dart:convert';
import 'dart:typed_data';



import 'package:employeemanagement/model/admin_availability_model.dart';
import 'package:employeemanagement/model/all_attendance_model.dart';
import 'package:employeemanagement/model/all_notification_model.dart';
import 'package:employeemanagement/model/notification_count_model.dart';
import 'package:employeemanagement/model/student_availability_model.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  static String baseUrl = "https://api.bigmonks.com/";
  static String registerUrl = "student/auth/register";
  static String loginUrl = "student/auth/login";
  static String profileUrl = "student/details/get";
  static String updateProfileUrl = "student/details/update";
  static String updatePasswordUrl = "student/auth/update/password";
  static String logoutUrl = "student/auth/logout";
  static String addAvailabilityUrl = "student/availability/add";
  static String getadminAvailabilityUrl = "/student/availability/get/all/admin/requested";
  static String getAllAvailabilityUrl = "student/availability/get/all";
  static String acceptAvailabilityUrl = "student/availability/accept/{id}/{manage}";
  static String notificationcountUrl = "student/notification/get/badge";
  static String getAllNotificationUrl = "student/notification/all";
  static String getAllAttendanceUrl = "student/attendance/get/all";
  static String getAttendanceSummaryUrl = "student/attendance/get/month";
  static String getAttendanceDetailUrl = "student/attendance/get/{attendance}";
  static String checkInUrl = "student/checking/manage/check-in";
  static String checkOutUrl = "student/checking/manage/check-out";

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

      // Add fields (form-data)
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

Future<bool> setAvailability({
  required String token,
  required List<String> dates,
}) async {
  print(" API CALL STARTED");
  try {
    print("TOKEN => $token");
    final response = await http.post(Uri.parse("$baseUrl$addAvailabilityUrl"),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
    body: jsonEncode({

        "date": dates,
    }),
    );
    print("URL => ${"$baseUrl$addAvailabilityUrl"}");

    print("AVAILABLITY STATUS: ${response.statusCode}");
    print("AVAILABILITY RESPONSE: ${response.body}");
    
    
  final data = jsonDecode(response.body);
  
  print("SUCCESS FIELD: ${data["success"]}");
    print("MESSAGE: ${data["message"]}");

    if((response.statusCode == 200 || response.statusCode == 201) && (data["success"] == true || data["success"].toString() == "true")){
      print("API Sucess: Availability stored ");
      print("Token => $token");
      return true;
    }else{
      print("API Failed: ${response.body}");
      return false;
    }
  }catch(e){
    print("Availability Error: $e");
    return false;
  }
}

Future<List<StudentAvailabilityModel>> fetchAvailability(String token) async {
  try{
    final response = await http.get(Uri.parse("$baseUrl$getAllAvailabilityUrl"),
    headers: {
      "Authorization": "Bearer $token",
    },
    );

    print("GET STATUS: ${response.statusCode}");
    print("GET RESPONSE: ${response.body}");

    final decoded = jsonDecode(response.body);

    if(response.statusCode == 200 && decoded["success"] == true){
      

    List list = decoded["data"]["availabilities"];

    return list.map<StudentAvailabilityModel>((item) {
      return StudentAvailabilityModel.fromJson(item);
    }).toList();
  }else{
    return [];
  }
  }catch(e){
    print("GET ERROR : $e");
    return [];
  }
}

Future<List<AdminAvailabilityModel>> getAdminRequest(String token) async {
  try{
    final response = await http.get(Uri.parse("$baseUrl$getadminAvailabilityUrl"),
    headers:  {
      "Authorization" : "Bearer $token",
    },
    );

    print("REQUEST LIST STATUS: ${response.statusCode}");
      print("REQUEST LIST RESPONSE: ${response.body}");

      final decoded = jsonDecode(response.body);

      if(response.statusCode == 200 && decoded["success"] == true) {
        List list = decoded["data"]["availabilities"];

        return list.map<AdminAvailabilityModel>((item) {
          return AdminAvailabilityModel.fromJson(item);
        }).toList();
      }else{
        return [];
      }
  }catch(e){
    print("GET REQUEST ERROR : $e");
    return [];
  }
}

Future<bool> updateAvailabilityStatus({
  required String token,
  required int id,
  required String action,
}) async {
  try{
    String url = acceptAvailabilityUrl
    .replaceAll("{id}", id.toString())
    .replaceAll("{manage}", action);

    final response = await http.put(Uri.parse("$baseUrl$url"),
    headers: {
      "Authorization" : "Bearer $token",
    },
    );

    print("URL => $url");
    print("STATUS => ${response.statusCode}");
    print("RESPONSE => ${response.body}");

    final decoded = jsonDecode(response.body);

    return response.statusCode == 200 && decoded["success"] == true;
  }catch(e){
    print("Error $e");
    return false;
  }
}

Future<NotificationCountModel?> getNotificationCount(String token) async {
  try{
    final response = await http.get(Uri.parse("$baseUrl$notificationcountUrl"),
    headers: {
      "Authorization": "Bearer $token",
    },
    );

    print("COUNT STATUS: ${response.statusCode}");
    print("COUNT RESPONSE: ${response.body}");

    final decoded = jsonDecode(response.body);

    if(response.statusCode == 200 && decoded["success"] == true) {
      return NotificationCountModel.fromJson(decoded["data"]);
    }else{
      return null;
    }
  }catch(e){
    print("COUNT ERROR: $e");
    return null;
  }
} 

Future<List<AllNotificationModel>> fetchNotifications(String token) async {
  try{
    final response = await http.get(Uri.parse("$baseUrl$getAllNotificationUrl"),
    headers: {
      "Authorization": "Bearer $token",
    },
    );

    print("NOTIFICATION STATUS: ${response.statusCode}");
    print("NOTIFICATION RESPONSE: ${response.body}");

    final decoded = jsonDecode(response.body);

    if(response.statusCode == 200 && decoded["success"] == true){
      List list = decoded["data"]["responses"];

      return list.map<AllNotificationModel>((item){
             return AllNotificationModel.fromJson(item);
      }).toList();
    }else{
      return [];
    }
  }catch(e){
    print("NOTIFICATION ERROR : $e");
    return [];
  }
}

// GET ALL (Summary + List)
Future<Map<String, dynamic>?> getAttendanceSummary(String token) async {
  final response = await http.get(
    Uri.parse("$baseUrl$getAttendanceSummaryUrl"),
    headers: {"Authorization": "Bearer $token"},
  );

  final decoded = jsonDecode(response.body);

  if (response.statusCode == 200 && decoded["success"] == true) {
    return decoded["data"];
  }
  return null;
}

//  GET LIST
Future<List<AllAttendanceModel>> getAttendanceList(String token) async {
  final response = await http.get(
    Uri.parse("$baseUrl$getAttendanceSummaryUrl"),
    headers: {"Authorization": "Bearer $token"},
  );

  final decoded = jsonDecode(response.body);

  if (decoded["success"] == true) {
    List list = decoded["data"]["responses"];

    return list.map((e) => AllAttendanceModel.fromJson(e)).toList();
  }
  return [];
}

// GET DETAIL
Future<AllAttendanceModel?> getAttendanceDetail(
    String token, int id) async {
  String url = getAttendanceDetailUrl.replaceAll("{attendance}", "$id");

  final response = await http.get(
    Uri.parse("$baseUrl$url"),
    headers: {"Authorization": "Bearer $token"},
  );

  final decoded = jsonDecode(response.body);

  if (decoded["success"] == true) {
    return AllAttendanceModel.fromJson(decoded["data"]);
  }
  return null;
}

Future<Map<String, dynamic>> fetchAttendanceSummary(String token) async {
  try {
  final now = DateTime.now();

final monthName = [
  "JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE",
  "JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"
][now.month - 1];

final year = now.year.toString();

final response = await http.get(
  Uri.parse("$baseUrl$getAttendanceSummaryUrl?month=$monthName&year=$year"),
  headers: {
    "Authorization": "Bearer $token",
  },
);

    print("STATUS => ${response.statusCode}");
    print("BODY => ${response.body}");

    // HANDLE EMPTY RESPONSE
    if (response.body.isEmpty) {
      print("EMPTY RESPONSE FROM API");
      return {};
    }

    final decoded = jsonDecode(response.body);

    // DEBUG FULL RESPONSE
    print("DECODED => $decoded");

    if (response.statusCode == 200 && decoded["success"] == true) {

      List list = decoded["data"]["responses"] ?? [];

      print("LIST LENGTH => ${list.length}");

      List<AllAttendanceModel> attendanceList =
          list.map((item) => AllAttendanceModel.fromJson(item)).toList();

      return {
        "list": attendanceList,
        "totalPresent": decoded["data"]["totalPresent"] ?? 0,
        "totalAbsent": decoded["data"]["totalAbsent"] ?? 0,
        "totalUpcoming": decoded["data"]["totalUpComingWork"] ?? 0,
        "totalHours": decoded["data"]["totalPresentHoursAndMinutes"] ?? "0:00",
      };

    } else {
      print(" API SUCCESS FALSE OR INVALID");
      return {};
    }
  } catch (e) {
    print(" ERROR => $e");
    return {};
  }
}
Future<bool> updateCheckIn({
  required String checkIn,
  required int attendanceId,
  required double latitude,
  required double longitude,
  required String token,
}) async {
  try {

    final response = await http.put(
      Uri.parse("$baseUrl$checkInUrl"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "checkInTime": checkIn,        
        "attendanceId": attendanceId,
        "latitude": latitude,
        "longitude": longitude,
      }),
    );

    final data = jsonDecode(response.body);

    print("STATUS => ${response.statusCode}");
    print("BODY => $data");

    if (response.statusCode == 200 && data["success"] == true) {
      print("${data["message"]}");
      return true;
    } else {
      print("${data["message"]}");
      return false;
    }

  } catch (e) {
    print("Error => $e");
    return false;
  }
}

Future<bool> updateCheckOut({
  required String checkOutTime,
  required int attendanceId,
  required double latitude,
  required double longitude,
  required Uint8List signature,
  required String token,
}) async {
  try {
    var request = http.MultipartRequest(
      'PUT',
       Uri.parse("$baseUrl$checkOutUrl"),
      );

      request.headers['Authorization'] = "Bearer $token";

      request.fields.addAll({
        "checkOutTime": checkOutTime,
        "attendanceId": attendanceId.toString(),
        "latitude": latitude.toString(),
        "longitude": longitude.toString(),
        
      });

      request.files.add(
       http.MultipartFile.fromBytes(
    'signature',
    signature,
    filename: 'signature.png',
  ),
);

      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      final decoded = jsonDecode(responseData);

      print("CHECKOUT STATUS => ${response.statusCode}");
      print("CHECKOUT RESPONSE => $decoded");

      return response.statusCode == 200 && decoded["success"] == true;
   
  }catch(e){
    print("CHECKOUT ERROR => $e");
    return false;
  }
}

Future<Map<String, dynamic>?> getCount() async {
  try {
    final response = await http.get(
      Uri.parse("$baseUrl/student/count"),
    );

    print("RAW BODY => ${response.body}");

    //  FIX: handle empty response
    if (response.body.isEmpty) {
      print("EMPTY RESPONSE BODY");
      return null;
    }

    final decoded = jsonDecode(response.body);

    print("COUNT STATUS: ${response.statusCode}");
    print("COUNT RESPONSE: $decoded");

    if (response.statusCode == 200) {
      return decoded;
    } else {
      return null;
    }
  } catch (e) {
    print("COUNT ERROR => $e");
    return null;
  }
}

Future<bool> updatePassword({
  required String token,
  required String oldPassword,
  required String newPassword,
}) async {
  try {
    final response = await http.put(
      Uri.parse("$baseUrl$updatePasswordUrl"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      }),
    );
    

    print("PASSWORD STATUS => ${response.statusCode}");
    print("PASSWORD RESPONSE => ${response.body}");

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200 && decoded["success"] == true) {
      // Success
      return true;
    } else {
      // Failed — log the error message from backend
      print("Failed update: ${decoded['message'] ?? 'Unknown error'}");
      return false;
    }
  } catch (e) {
    print("PASSWORD ERROR => $e");
    return false;
  }
}

// Future<Map<String, dynamic>?> fetchAttendanceSummary(String token) async {
//   try {
//     final response = await http.get(
//       Uri.parse("$baseUrl$getAttendanceSummaryUrl"),
//       headers: {
//         "Authorization": "Bearer $token",
//       },
//     );

//     print("SUMMARY STATUS: ${response.statusCode}");
//     print("SUMMARY RESPONSE: ${response.body}");

//     final decoded = jsonDecode(response.body);

//     if (response.statusCode == 200 && decoded["success"] == true) {
//       return decoded["data"]; // contains summary + responses
//     } else {
//       return null;
//     }
//   } catch (e) {
//     print("SUMMARY ERROR: $e");
//     return null;
//   }
// }

// Future<List<AllAttendanceModel>> fetchAttendanceList(String token) async {
//   try {
//     final response = await http.get(
//       Uri.parse("$baseUrl$getAttendanceSummaryUrl"),
//       headers: {
//         "Authorization": "Bearer $token",
//       },
//     );

//     final decoded = jsonDecode(response.body);

//     if (response.statusCode == 200 && decoded["success"] == true) {
//       List list = decoded["data"]["responses"];

//       return list.map<AllAttendanceModel>((item) {
//         return AllAttendanceModel.fromJson(item);
//       }).toList();
//     } else {
//       return [];
//     }
//   } catch (e) {
//     print("LIST ERROR: $e");
//     return [];
//   }
// }

// Future<AllAttendanceModel?> fetchAttendanceDetail(
//     String token, int id) async {
//   try {
//     String url = getAttendanceDetailUrl
//         .replaceAll("{attendance}", id.toString());

//     final response = await http.get(
//       Uri.parse("$baseUrl$url"),
//       headers: {
//         "Authorization": "Bearer $token",
//       },
//     );

//     print("DETAIL STATUS: ${response.statusCode}");
//     print("DETAIL RESPONSE: ${response.body}");

//     final decoded = jsonDecode(response.body);

//     if (response.statusCode == 200 && decoded["success"] == true) {
//       return AllAttendanceModel.fromJson(decoded["data"]);
//     } else {
//       return null;
//     }
//   } catch (e) {
//     print("DETAIL ERROR: $e");
//     return null;
//   }
// }

// Future<List<AllAttendanceModel>> fetchMonthlyAttendance(String token) async {
//   try {
//     final response = await http.get(
//       Uri.parse("$baseUrl$getAllAttendanceUrl"), // month endpoint if needed
//       headers: {
//         "Authorization": "Bearer $token",
//       },
//     );

//     print("MONTH STATUS: ${response.statusCode}");
//     print("MONTH RESPONSE: ${response.body}");

//     final decoded = jsonDecode(response.body);

//     if (response.statusCode == 200 && decoded["success"] == true) {

//       // If backend returns single object (your case)
//       if (decoded["data"] is Map) {
//         return [AllAttendanceModel.fromJson(decoded["data"])];
//       }

//       // If list
//       List list = decoded["data"]["responses"] ?? [];

//       return list.map<AllAttendanceModel>((item) {
//         return AllAttendanceModel.fromJson(item);
//       }).toList();
//     } else {
//       return [];
//     }
//   } catch (e) {
//     print("MONTH ERROR: $e");
//     return [];
//   }
// }

Future<bool> logoutEmployee(String token) async {
  try{
    final response = await http.put(Uri.parse("$baseUrl$logoutUrl"),
    headers: {
      "Authorization":"Bearer $token",
      "Content-Type": "application/json"
    },
    body: jsonEncode({}),
    );

    print("LOGOUT STATUS: ${response.statusCode}");
    print("LOGOUT RESPONSE: ${response.body}");

    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }catch(e){
    print("Logout Error: $e");
    return false;
  }
}

}