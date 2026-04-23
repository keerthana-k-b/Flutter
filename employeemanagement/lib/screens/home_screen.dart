
import 'package:employeemanagement/provider/employee_provider.dart';
import 'package:employeemanagement/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:signature/signature.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double? latitude;
  double? longitude;

  final SignatureController _signatureController = SignatureController(
  penStrokeWidth: 3,
  penColor: Colors.black,
  exportBackgroundColor: Colors.white,
);

 @override
void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    final provider = Provider.of<EmployeeProvider>(context, listen: false);

    await provider.loadToken();

    if (provider.token != null) {
      await provider.fetchProfile(provider.token!);
      await provider.fetchAttendanceData();
      await provider.fetchNotificationCount();
      await provider.fetchCount();
      
    }

    await getCurrentLocation();
  });
}


  ///  FORMAT TIME (UTC → LOCAL)
   
  
//   String formatTime(String? utcTime) {
//   if (utcTime == null) return "--:--";

//   final utc = DateTime.parse(utcTime);

//   // UK time (BST = UTC+1)
//   final ukTime = utc.toLocal();

//   return "${ukTime.hour.toString().padLeft(2, '0')}:${ukTime.minute.toString().padLeft(2, '0')}";
// }

String formatTime(String? utcTime) {
  if (utcTime == null) return "--:--";

  final utc = DateTime.parse(utcTime).toUtc();

  // UK timezone (UTC+0 or UTC+1 depending DST)
  final ukTime = utc.add(const Duration(hours: 1)); // simple fix

  return "${ukTime.hour.toString().padLeft(2, '0')}:${ukTime.minute.toString().padLeft(2, '0')}";
}


  ///  WORKING HOURS FIX (UTC)
  String calculateWorkingHours(String? checkIn) {
    if (checkIn == null) return "0h 0m";

    final start = DateTime.parse(checkIn).toUtc();
    final now = DateTime.now().toUtc();

    final diff = now.difference(start);

    int hours = diff.inHours;
    int minutes = diff.inMinutes % 60;

    return "${hours}h ${minutes}m";
  }

  ///  LOCATION
  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) return;

      Position position = await Geolocator.getCurrentPosition();

      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });

    } catch (e) {
      print("LOCATION ERROR => $e");
    }
  }

  
  void showCheckOutSheet(BuildContext context) {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
                ///  HEADER
                Row(
                  children: [
                    Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child:Icon(Icons.verified_user, color: Colors.blue),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Checkout Verification",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Supervisor approval required",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
                    ),
                    IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
                    )
                  ],
                ),
            
                 SizedBox(height: 18),
            
                ///  NAME LABEL
                Row(
                  children: [
                    Icon(Icons.person, size: 18, color: Colors.blue),
                    SizedBox(width: 6),
                    Text("Supervisor Name",
              style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
            
                 SizedBox(height: 8),
            
                /// NAME FIELD
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter full name",
                    prefixIcon:  Icon(Icons.person_outline,color: Colors.blue),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding:  EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
                    ),
                  ),
                ),
            
                 SizedBox(height: 16),
            
                ///  PHONE LABEL
                Row(
                  children:  [
                    Icon(Icons.phone, size: 18, color: Colors.blue),
                    SizedBox(width: 6),
                    Text("Phone Number",
              style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
            
                 SizedBox(height: 8),
            
                /// PHONE FIELD
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter phone number",
                    prefixIcon:  Icon(Icons.phone_outlined,color: Colors.blue),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
                    ),
                  ),
                ),
            
                 SizedBox(height: 18),
            
                ///  SIGNATURE LABEL
                Row(
                  children: [
                    Icon(Icons.draw, size: 18, color: Colors.blue),
                    SizedBox(width: 6),
                    Text("Supervisor Signature",
              style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
            
                 SizedBox(height: 10),
            
                /// SIGNATURE PAD
                Stack(
                  children: [
                    Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.blue.shade100),
              color: Colors.grey.shade50,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Signature(
                controller: _signatureController,
                backgroundColor: Colors.transparent,
              ),
            ),
                    ),
            
                    /// HINT (auto hide after draw)
                    if (_signatureController.isEmpty)
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.gesture, color: Colors.grey),
                  SizedBox(height: 5),
                  Text("Draw signature here",
                      style: TextStyle(color: Colors.grey)),
                  Text("Use finger or stylus",
                      style: TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              ),
            ),
                  ],
                ),
            
                ///  CLEAR BUTTON
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
            _signatureController.clear();
                    },
                    icon:  Icon(Icons.refresh, color: Colors.red),
                    label:  Text(
            "Clear Signature",
            style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
            
                const SizedBox(height: 18),
            
                /// BUTTONS
                Row(
                  children: [
                    Expanded(
            child: SizedBox(
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
            child: SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () async {
                  await handleCheckout(
                    context,
                    nameController.text,
                    phoneController.text,
                  );
                },
                child: const Text(
                  "Confirm Checkout",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ),
      );
    },
  );
}

Future<void> handleCheckout(
    BuildContext context,
    String name,
    String phone,
) async {
  final provider =
      Provider.of<EmployeeProvider>(context, listen: false);

  final attendance = provider.todayAttendance;

  if (attendance == null) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("No attendance found")),
    );
    return;
  }

   if (name.isEmpty || phone.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Please fill all fields")),
    );
    return;
  }

  if (_signatureController.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Please provide signature")),
    );
    return;
  }

  if (latitude == null || longitude == null) {
  await getCurrentLocation(); // try again

  if (latitude == null || longitude == null) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Unable to get location")),
    );
    return;
  }
}


final signatureBytes = await _signatureController.toPngBytes();

if (signatureBytes == null) {
  ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text("Signature capture failed")),
  );
  return;
}

final success = await provider.updateCheckOut(
  attendanceId: attendance.attendanceId,
  latitude: latitude!,
  longitude: longitude!,
  signature: signatureBytes, 
);
  Navigator.pop(context); // close sheet

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content:
          Text(success ? "Checkout Successful" : "Checkout Failed"),
    ),
  );
}


@override
void dispose() {
  _signatureController.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<EmployeeProvider>(context);

    print("Count: ${provider.count}");

    final attendance = provider.todayAttendance;

if (provider.isLoading) {
  return  Center(child: CircularProgressIndicator());
}

String getGreeting() {
  final now = DateTime.now().toLocal(); // auto handles timezone

  final hour = now.hour;

  if (hour < 12) return "Good Morning 👋";
  if (hour < 17) return "Good Afternoon ☀️";
  return "Good Evening 🌙";
}


    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
  elevation: 0,
  backgroundColor: Colors.transparent,
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3A7BD5), Color(0xFF00D2FF)],
      ),
    ),
  ),

  title: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        getGreeting(),
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white70,
        ),
      ),
      const SizedBox(height: 2),
      Text(
  provider.profileData?['fullName'] ?? "User",
  style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  overflow: TextOverflow.ellipsis,
),
    ],
  ),

  actions: [
    Consumer<EmployeeProvider>(
      builder: (context, p, _) {
        return Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationScreen(),
                  ),
                );
              },
            ),

           // if (p.notificationCount > 0)
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Center(
                    child: Text(
                      p.notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    ),
  ],
),


      body: SingleChildScrollView(
        padding:  EdgeInsets.all(16),
        child: Column(
          children: [

            ///  DATE SELECTOR (UNCHANGED )
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  final today = DateTime.now();
                  final date = today.add(Duration(days: index));

                  return Container(
                    width: 60,
                    margin:  EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: index == 0 ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
                              [date.weekday - 1],
                          style: TextStyle(
                            color: index == 0 ? Colors.white : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${date.day}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: index == 0 ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

             SizedBox(height: 20),

            ///  STATUS
            buildStatusCard(attendance),

             SizedBox(height: 20),

            ///  CLOCK
            Row(
              children: [
                Expanded(child: buildTimeCard("Clock In", formatTime(attendance?.checkIn))),
                 SizedBox(width: 12),
                Expanded(child: buildTimeCard("Clock Out", formatTime(attendance?.checkOut))),
              ],
            ),

             SizedBox(height: 20),

            /// TOTAL HOURS
            Container(
  width: double.infinity,
  padding:  EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  decoration: BoxDecoration(
    gradient:  LinearGradient(
      colors: [Color(0xFF00c6ff), Color(0xFF0072ff)],
    ),
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        color: Colors.blue.withOpacity(0.25),
        blurRadius: 8,
        offset:  Offset(0, 3),
      )
    ],
  ),
  child: Row(
    children: [
      /// ⏱ Icon
      Container(
        padding:  EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child:  Icon(Icons.access_time, color: Colors.white),
      ),

       SizedBox(width: 12),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text("Total Hours",
              style: TextStyle(color: Colors.white70, fontSize: 12)),
           SizedBox(height: 3),
          Text(
            attendance != null
                ? (attendance.checkOut != null
                    ? attendance.formattedTotalHours
                    : calculateWorkingHours(attendance.checkIn))
                : "0h 0m",
            style:  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ],
  ),
),

             SizedBox(height: 30),

            ///  CHECK-IN BUTTON
            provider.isLoading
                ? CircularProgressIndicator()
                : GestureDetector(
                    onTap: () async {
  if (attendance == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("No work today")),
    );
    return;
  }

  // CHECK OUT
  if (attendance.checkIn != null && attendance.checkOut == null) {
    showCheckOutSheet(context);
    return;
  }

  // ALREADY DONE
  if (attendance.checkOut != null) {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Work already completed")),
    );
    return;
  }

  // CHECK IN
  if (attendance.checkIn == null) {
    if (latitude == null || longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text("Fetching location...")),
      );
      return;
    }

    final success = await provider.updateCheckIn(
      attendanceId: attendance.attendanceId,
      latitude: latitude!,
      longitude: longitude!,
      token: provider.token!,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? "Check-in Successful" : "Failed"),
      ),
    );
  }
},
                   child: Container(
    height: 85,
    width: 85,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        colors: attendance?.checkOut != null
            ? [Colors.grey, Colors.grey]
            : attendance?.checkIn != null
                ? [Color(0xFFFF9966), Color(0xFFFF5E62)] // checkout
                : [Color(0xFF00b09b), Color(0xFF96c93d)], // checkin
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 12,
          offset:  Offset(0, 6),
        )
      ],
    ),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          attendance == null || attendance.checkIn == null
              ? Icons.login
              : attendance.checkOut == null
                  ? Icons.logout
                  : Icons.check_circle,
          color: Colors.white,
          size: 26,
        ),
        SizedBox(height: 6),
        Text(
          attendance == null || attendance.checkIn == null
              ? "CHECK IN"
              : attendance.checkOut == null
                  ? "CHECK OUT"
                  : "DONE",
          style:  TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ],
    ),
  ),
),
                  
          ],
        ),
      ),
    );
  }


Widget buildStatusCard(attendance) {
  return Container(
    padding:  EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient:  LinearGradient(
        colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
      ),
      borderRadius: BorderRadius.circular(22),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(0.25),
          blurRadius: 12,
          offset: const Offset(0, 6),
        )
      ],
    ),
    child: Row(
      children: [
        
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child:  Icon(Icons.explore, color: Colors.white, size: 26),
        ),

         SizedBox(width: 14),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Work Status",
                  style: TextStyle(color: Colors.white70, fontSize: 13)),

               SizedBox(height: 4),

              Text(
                attendance == null
                    ? "No Work Today"
                    : attendance.checkOut != null
                        ? "Completed "
                        : attendance.checkIn != null
                            ? "In Progress "
                            : "Not Checked In",
                style:  TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTimeCard(String title, String time) {
  return Container(
    padding:  EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 3),
        )
      ],
    ),
    child: Column(
      children: [
        Icon(
          title == "Clock In" ? Icons.login : Icons.logout,
          color: Colors.blue,
        ),
         SizedBox(height: 6),
        Text(title, style: TextStyle(color: Colors.grey)),
         SizedBox(height: 6),
        Text(time,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

}