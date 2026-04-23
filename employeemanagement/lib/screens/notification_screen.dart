import 'package:employeemanagement/model/admin_availability_model.dart';
import 'package:employeemanagement/model/all_notification_model.dart';
import 'package:employeemanagement/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int selectedIndex = 0; // 0 = Notifications, 1 = Requests

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = Provider.of<EmployeeProvider>(context, listen: false);
      provider.fetchAdminRequests();
      provider.fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffF2F6FF),

      /// APP BAR
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
      ),

      /// BODY
      body: Column(
        children: [

          /// SEGMENT SWITCH (Notifications / Requests)
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue.shade100.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [

                  /// Notifications Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedIndex = 0);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? Colors.blue.shade600
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Notifications",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 0
                                  ? Colors.white
                                  : Colors.blue.shade600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// Requests Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedIndex = 1);
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: selectedIndex == 1
                              ? Colors.blue.shade600
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            "Requests",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 1
                                  ? Colors.white
                                  : Colors.blue.shade600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// BODY LIST
          Expanded(
            child: provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : selectedIndex == 0
                    ? buildNotificationList(provider)
                    : buildRequestList(provider),
          ),
        ],
      ),
    );
  }

  /// NOTIFICATIONS LIST
  Widget buildNotificationList(EmployeeProvider provider) {
    if (provider.notifications.isEmpty) {
      return Center(
        child: Text(
          "No Notifications",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: provider.notifications.length,
      itemBuilder: (context, index) {
        final item = provider.notifications[index];
        return buildNotificationCard(item);
      },
    );
  }

  /// REQUESTS LIST
  Widget buildRequestList(EmployeeProvider provider) {
    if (provider.adminRequests.isEmpty) {
      return Center(
        child: Text(
          "No Requests",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: provider.adminRequests.length,
      itemBuilder: (context, index) {
        final item = provider.adminRequests[index];
        return buildRequestCard(item, provider);
      },
    );
  }

  /// NOTIFICATION CARD
  Widget buildNotificationCard(AllNotificationModel item) {
    Color indicatorColor;

    switch (item.status) {
      case "green":
        indicatorColor = Colors.green;
        break;
      case "blue":
        indicatorColor = Colors.blue;
        break;
      case "red":
        indicatorColor = Colors.red;
        break;
      default:
        indicatorColor = Colors.grey;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT DOT
          Container(
            width: 12,
            height: 12,
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: indicatorColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 14),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
               SizedBox(height: 6),
                Text(
                  item.description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
               SizedBox(height: 8),
                Text(
                  item.date,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// REQUEST CARD
  Widget buildRequestCard(
      AdminAvailabilityModel item, EmployeeProvider provider) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.homeCareName ?? "Care Home",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
         SizedBox(height: 6),
          Text(
            item.city ?? "",
            style: TextStyle(color: Colors.grey.shade600),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
              SizedBox(width: 6),
              Text(
                item.date,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
          SizedBox(height: 16),

          /// BUTTONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    bool success = await provider.updateAvailabilityStatus(
                        id: item.availabilityId, action: "ACCEPT");

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text("Accepted")),
                      );
                    }
                  },
                  child:  Text("Accept"),
                ),
              ),
               SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: BorderSide(color: Colors.red),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    bool success = await provider.updateAvailabilityStatus(
                        id: item.availabilityId, action: "REJECT");

                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text("Rejected")),
                      );
                    }
                  },
                  child: Text("Reject"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// import 'package:employeemanagement/model/admin_availability_model.dart';
// import 'package:employeemanagement/model/all_notification_model.dart';
// import 'package:employeemanagement/provider/employee_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key});

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       final provider = Provider.of<EmployeeProvider>(context, listen: false);
//       provider.fetchAdminRequests();
//       provider.fetchNotifications();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     final provider = Provider.of<EmployeeProvider>(context);

//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F7FB),

//         /// 🔥 APPBAR
//         appBar: AppBar(
//           title: const Text(
//             "Notifications",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           centerTitle: true,
//           elevation: 0,
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF4A90E2), Color(0xFF007AFF)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),

//           /// 🔹 MODERN TAB BAR
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(60),
//             child: Container(
//               margin: const EdgeInsets.all(12),
//               padding: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.25),
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: const TabBar(
//                 indicator: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                 ),
//                 labelColor: Colors.black,
//                 unselectedLabelColor: Colors.white,
//                 tabs: [
//                   Tab(text: "Notifications"),
//                   Tab(text: "Requests"),
//                 ],
//               ),
//             ),
//           ),
//         ),

//         /// 🔥 BODY
//         body: provider.isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : TabBarView(
//                 children: [
//                   buildNotificationTab(provider),
//                   buildRequestTab(provider),
//                 ],
//               ),
//       ),
//     );
//   }

//   /// 🔔 NOTIFICATION TAB
//   Widget buildNotificationTab(EmployeeProvider provider) {
//     if (provider.notifications.isEmpty) {
//       return buildEmptyState(
//         icon: Icons.notifications_off,
//         text: "No Notifications Yet",
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       itemCount: provider.notifications.length,
//       itemBuilder: (context, index) {
//         return buildNotificationCard(provider.notifications[index]);
//       },
//     );
//   }

//   /// 📩 REQUEST TAB
//   Widget buildRequestTab(EmployeeProvider provider) {
//     if (provider.adminRequests.isEmpty) {
//       return buildEmptyState(
//         icon: Icons.assignment_late,
//         text: "No Requests Available",
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       itemCount: provider.adminRequests.length,
//       itemBuilder: (context, index) {
//         return buildRequestCard(provider.adminRequests[index], provider);
//       },
//     );
//   }

//   /// 🔥 EMPTY STATE UI
//   Widget buildEmptyState({required IconData icon, required String text}) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 60, color: Colors.grey.shade400),
//           const SizedBox(height: 12),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🔔 NOTIFICATION CARD
//   Widget buildNotificationCard(AllNotificationModel item) {
//     Color color;

//     switch (item.status) {
//       case "green":
//         color = Colors.green;
//         break;
//       case "blue":
//         color = Colors.blue;
//         break;
//       case "red":
//         color = Colors.red;
//         break;
//       default:
//         color = Colors.grey;
//     }

//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           /// ICON
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(Icons.notifications, color: color),
//           ),

//           const SizedBox(width: 14),

//           /// TEXT
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   item.description,
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                     height: 1.4,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   item.date,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 📩 REQUEST CARD
//   Widget buildRequestCard(
//       AdminAvailabilityModel item, EmployeeProvider provider) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           /// HEADER
//           Row(
//             children: [
//               const Icon(Icons.event, size: 18, color: Colors.blue),
//               const SizedBox(width: 8),
//               Text(
//                 item.date,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 12),

//           /// DETAILS
//           Text(
//             item.homeCareName ?? "N/A",
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//             ),
//           ),

//           const SizedBox(height: 4),

//           Text(
//             item.city ?? "N/A",
//             style: TextStyle(color: Colors.grey.shade600),
//           ),

//           const SizedBox(height: 18),

//           /// BUTTONS
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: Colors.red,
//                     side: const BorderSide(color: Colors.red),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () async {
//                     bool success = await provider.updateAvailabilityStatus(
//                         id: item.availabilityId,
//                         action: "REJECT");

//                     if (success) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Rejected")),
//                       );
//                     }
//                   },
//                   child: const Text("Reject"),
//                 ),
//               ),

//               const SizedBox(width: 12),

//               Expanded(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () async {
//                     bool success = await provider.updateAvailabilityStatus(
//                         id: item.availabilityId,
//                         action: "ACCEPT");

//                     if (success) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Accepted")),
//                       );
//                     }
//                   },
//                   child: const Text("Accept"),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }