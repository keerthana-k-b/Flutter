import 'dart:typed_data';

import 'package:employeemanagement/model/admin_availability_model.dart';
import 'package:employeemanagement/model/all_attendance_model.dart';
import 'package:employeemanagement/model/all_notification_model.dart';
import 'package:employeemanagement/model/student_availability_model.dart';
import 'package:employeemanagement/screens/bottom_navigation_screen.dart';
import 'package:employeemanagement/screens/login_screen.dart';
import 'package:employeemanagement/service/employee_service.dart';
import 'package:employeemanagement/service/sharedpreferences/storage_service.dart';
import 'package:flutter/material.dart';

class EmployeeProvider extends ChangeNotifier{
 final EmployeeService _employeeService = EmployeeService();

 bool _isLoading = false;
 bool get isLoading => _isLoading;
 Map<String, dynamic>? profileData;
 String? token;
 List<AdminAvailabilityModel> adminRequests = [];
 int notificationCount = 0;
 List<AllNotificationModel> notifications = [];
 List<AllAttendanceModel> attendanceList = [];
 int count = 0;
 // SUMMARY DATA
int totalPresent = 0;
int totalAbsent = 0;
int totalUpcoming = 0;
String totalHours = "0.00";

// DETAIL DATA
AllAttendanceModel? selectedAttendance;
AllAttendanceModel? todayAttendance;


// CONSTRUCTOR
  EmployeeProvider() {
    loadToken();
  }


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

        Navigator.push(context, MaterialPageRoute(builder: (_)=>BottomNavigationScreen()),
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
  // required String gender,
  // required String dateOfBirth,
  // required String nationality,
  // required String country,
  // required String state,
  // required String city,
  // required String address,
  // required String postalCode,
  // required String secondEmail,
  // required String username,
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
    // "gender": gender,
    // "dateOfBirth": dateOfBirth,
    // "nationality": nationality,
    // "country": country,
    // "state": state,
    // "city": city,
    // "address": address,
    // "postalCode": postalCode,
    // "secondEmail": secondEmail.isEmpty ? "" : secondEmail,
    // "username": username.isEmpty ? "" : username,
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

Future<bool> setAvailability(List<String> dates) async {
  if(token == null) return false;

  _isLoading = true;
  notifyListeners();

  bool success = await _employeeService.setAvailability(
    token: token!, 
    dates: dates,
    );

    _isLoading = false;
    notifyListeners();

    return success;
}

Future<List<StudentAvailabilityModel>> fetchAvailability() async {
  if(token == null){
    await loadToken();
  }
  
  if(token == null) return [];

  _isLoading = true;
  notifyListeners();

 List<StudentAvailabilityModel> result =
   await _employeeService.fetchAvailability(token!);

   _isLoading = false;
   notifyListeners();

   return result;
}

Future<void> fetchAdminRequests() async {
  if(token == null){
    await loadToken();
  }

  if(token == null) return;

  _isLoading = true;
  notifyListeners();

  adminRequests = await _employeeService.getAdminRequest(token!);

  _isLoading = false;
  notifyListeners();
}

Future<bool> updateAvailabilityStatus({
  required int id,
  required String action, //ACCEPT or REJECT
}) async {
  if(token == null) return false;

  bool success = await _employeeService.updateAvailabilityStatus(
    token: token!,
    id: id,
    action: action,
    );

    if(success){
      await fetchAdminRequests();
    }
    return success;
}

Future<void> fetchNotificationCount() async {
  if(token == null){
    await loadToken();
  }

  if(token == null) return;

  final result = await _employeeService.getNotificationCount(token!);

  if(result != null){
    notificationCount = result.count;
  }else{
    notificationCount = 0;
  }

  notifyListeners();
}

Future<void> fetchNotifications() async {
  if(token == null){
    await loadToken();
  }

  if(token == null) return;

  _isLoading = true;
  notifyListeners();

  notifications = await _employeeService.fetchNotifications(token!);

  _isLoading = false;
  notifyListeners();
}

Future<void> fetchAttendanceData() async {
  if (token == null) await loadToken();
  if (token == null) return;

  _isLoading = true;
  notifyListeners();

  final result =
    await _employeeService.fetchAttendanceSummary(token!);

print("API RESULT => $result");

if (result != null && result.isNotEmpty) {
    attendanceList = result["list"] ?? [];

    totalPresent = result["totalPresent"] ?? 0;
    totalAbsent = result["totalAbsent"] ?? 0;
    totalUpcoming = result["totalUpcoming"] ?? 0;
    totalHours = result["totalHours"] ?? "0:00";

   print("FULL LIST => $attendanceList");

   for (var item in attendanceList) {
  print("DATE => ${item.date}");
  print("CHECKIN => ${item.checkIn}");
}

    // FIND TODAY ATTENDANCE (FIXED UTC)
todayAttendance = null;

if (attendanceList.isNotEmpty) {
  try {
    todayAttendance = attendanceList.firstWhere(
      (item) {
        final date = DateTime.parse(item.date);
        final now = DateTime.now();
        return date.year == now.year &&
               date.month == now.month &&
               date.day == now.day;
      },
    );
  } catch (e) {
    //todayAttendance = attendanceList.first;
    todayAttendance = null;
  }
}


print("TODAY FOUND => $todayAttendance");
  }
  _isLoading = false;
  notifyListeners();
}

Future<bool> updateCheckIn({
  required int attendanceId,
  required double latitude,
  required double longitude,
  required String token,
})async{

  _isLoading = true;
  notifyListeners();

  final result = await _employeeService.updateCheckIn(
    checkIn: DateTime.now().toUtc().toIso8601String(),
     attendanceId: attendanceId, 
     latitude: latitude, 
     longitude: longitude, 
     token: token,
     );

     print("CHECKIN => ${todayAttendance?.checkIn}");

     if(result){
     
      await fetchAttendanceData();
     }
     
     print("ATTENDANCE LIST LENGTH => ${attendanceList.length}");

for (var item in attendanceList) {
  print("DATE => ${item.date} | CHECKIN => ${item.checkIn}");
}

     _isLoading = false;
     notifyListeners();

     return result;
}


Future<bool> updateCheckOut({
  required int attendanceId,
  required double latitude,
  required double longitude,
  required Uint8List signature,
}) async {

  if(token == null) return false;

  _isLoading = true;
  notifyListeners();

  // final formattedTime = DateTime.now()
  //    .toIso8601String()
  //    .split(".")
  //    .first;
  final now = DateTime.now();

final formattedTime =
    "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}T"
    "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
    
      final result = await _employeeService.updateCheckOut(
        checkOutTime: formattedTime,
        attendanceId: attendanceId, 
        latitude: latitude, 
        longitude: longitude, 
        signature: signature,
        token: token!,
        );

        if(result){
          await fetchAttendanceData();
        }

        _isLoading = false;
        notifyListeners();

        return result;
}

Future<void> fetchCount() async {
  final response = await _employeeService.getCount();

  if (response != null &&
      response['data'] != null &&
      response['data']['count'] != null) {

    count = response['data']['count'];
  } else {
    count = 0;
  }

  notifyListeners();
}

Future<bool> updatePassword({
  required String oldPassword,
  required String newPassword,
}) async {

  if (token == null) return false;

  _isLoading = true;
  notifyListeners();

  final success = await _employeeService.updatePassword(
    token: token!,
    oldPassword: oldPassword,
    newPassword: newPassword,
  );

  _isLoading = false;
  notifyListeners();

  return success;
}

// Future<void> fetchAttendance() async {
//   if (token == null) await loadToken();
//   if (token == null) return;

//   _isLoading = true;
//   notifyListeners();

//   final data = await _employeeService.fetchAttendanceSummary(token!);

//   if (data != null) {

//     //  SUMMARY
//     totalPresent = data["totalPresent"] ?? 0;
//     totalAbsent = data["totalAbsent"] ?? 0;
//     totalUpcoming = data["totalUpComingWork"] ?? 0;
//     totalHours = data["totalPresentHours"] ?? 0;

//     //  LIST
//     List list = data["responses"];

//     attendanceList = list.map<AllAttendanceModel>((item) {
//       return AllAttendanceModel.fromJson(item);
//     }).toList();
//   }

//   _isLoading = false;
//   notifyListeners();
// }

// Future<void> fetchAttendanceDetail(int id) async {
//   if (token == null) await loadToken();
//   if (token == null) return;

//   _isLoading = true;
//   notifyListeners();

//   selectedAttendance =
//       await _employeeService.fetchAttendanceDetail(token!, id);

//   _isLoading = false;
//   notifyListeners();
// }

Future<void> logout(BuildContext context) async {
if(token != null && token!.isNotEmpty){
  await _employeeService.logoutEmployee(token!);
}

  token = null;
  profileData = null;

  await StorageService.clearToken(); // clear token

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => LoginScreen()),
    (route) => false,
  );

  notifyListeners();
}

  Future<void> loadToken() async {
  token = await StorageService.getToken();
  print("TOKEN LOADED => $token");
  notifyListeners();
}
   

}