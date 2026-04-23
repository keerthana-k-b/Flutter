import 'package:employeemanagement/model/all_attendance_model.dart';
import 'package:employeemanagement/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  final List<String> months = [
    "Jan","Feb","Mar","Apr","May","Jun",
    "Jul","Aug","Sep","Oct","Nov","Dec"
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<EmployeeProvider>(context, listen: false)
          .fetchAttendanceData();
    });
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<EmployeeProvider>(context);

    // FILTER DATA
    List<AllAttendanceModel> filteredList =
        provider.attendanceList.where((item) {
      DateTime date = DateTime.parse(item.date);
      return date.year == selectedYear &&
          date.month == selectedMonth;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title:  Text("Attendance"),
        backgroundColor: Colors.blue,
        actions: [
          DropdownButton<int>(
            value: selectedYear,
            underline: SizedBox(),
            dropdownColor: Colors.white,
            items: List.generate(5, (index) {
              int year = DateTime.now().year - index;
              return DropdownMenuItem(
                value: year,
                child: Text("$year"),
              );
            }),
            onChanged: (value) {
              setState(() {
                selectedYear = value!;
              });
            },
          ),
           SizedBox(width: 10)
        ],
      ),

      body: provider.isLoading
          ?  Center(child: CircularProgressIndicator())
          : Column(
              children: [

                /// MONTH SELECTOR (FIXED - NO CUT)
                SizedBox(
                  height: 75,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: months.length,
                    itemBuilder: (context, index) {

                      bool isSelected = selectedMonth == index + 1;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMonth = index + 1;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin:  EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ?  LinearGradient(
                                    colors: [Colors.blue, Colors.lightBlueAccent],
                                  )
                                : null,
                            color: isSelected ? null : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.4),
                                      blurRadius: 10,
                                      offset:  Offset(0, 4),
                                    )
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              months[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// SUMMARY BOXES
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: [
                      summaryBox("Present", provider.totalPresent.toString(), Colors.green),
                      summaryBox("Absent", provider.totalAbsent.toString(), Colors.red),
                      summaryBox("Upcoming", provider.totalUpcoming.toString(), Colors.orange),
                      summaryBox("Hours", provider.totalHours, Colors.blue),
                    ],
                  ),
                ),

                /// 🔹 LIST
                Expanded(
                  child: filteredList.isEmpty
                      ? Center(child: Text("No Attendance"))
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          itemCount: filteredList.length,
                          itemBuilder: (context, index) {
                            return buildAttendanceCard(filteredList[index]);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  /// SUMMARY BOX
  Widget summaryBox(String title, String value, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        padding: EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: color,
              ),
            ),
             SizedBox(height: 5),
            Text(title),
          ],
        ),
      ),
    );
  }

  /// ATTENDANCE CARD
  Widget buildAttendanceCard(AllAttendanceModel item) {

    Color statusColor;

    switch (item.status) {
      case "ABSENT":
        statusColor = Colors.red;
        break;
      case "IS_PRESENT_ERROR":
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.green;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [

              /// ICON
              CircleAvatar(
                radius: 25,
                backgroundColor: statusColor.withOpacity(0.2),
                child: Icon(Icons.calendar_today, color: statusColor),
              ),

               SizedBox(width: 12),

              /// DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.homeCareName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                   SizedBox(height: 4),
                    Text("City: ${item.city}"),
                    Text("Date: ${item.date}"),
                    Text("Hours: ${item.formattedTotalHours}"),
                  ],
                ),
              ),

              /// STATUS
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  item.status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:employeemanagement/model/all_attendance_model.dart';
// import 'package:employeemanagement/provider/employee_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class AttendanceScreen extends StatefulWidget {
//   const AttendanceScreen({super.key});

//   @override
//   State<AttendanceScreen> createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {

//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;

//   final List<String> months = ["Jan","Feb","Mar","Apr","May","Jun", "Jul","Aug","Sep","Oct","Nov","Dec"];
  
//   @override
//   void initState(){
//     super.initState();
//     Future.microtask((){
//       Provider.of<EmployeeProvider>(context, listen: false).fetchAttendane();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     final provider = Provider.of<EmployeeProvider>(context);

//     List filteredList = provider.attendanceList.where((item){
//       DateTime date = DateTime.parse(item.date);

//        return date.year == selectedYear &&
//              date.month == selectedMonth;
//     }).toList();

//     return Scaffold(
//     appBar: AppBar(
//       title: Text("Attendane"),
//       actions: [
//         DropdownButton<int>(
//           value: selectedYear,
//           underline: SizedBox(),
//           items: List.generate(5, (index) {
//               int year = DateTime.now().year - index;
//               return DropdownMenuItem(
//                 value: year,
//                 child: Text("$year"),
//               );
//             }), 
//             onChanged: (value) {
//               setState(() {
//                 selectedYear = value!;
//               });
//             },
//           ),
//           SizedBox(width: 10)
//       ],
//     ),
    
//     body: Column(
//         children: [

//           /// MONTH SELECTOR
//           SizedBox(
//             height: 60,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: months.length,
//               itemBuilder: (context, index) {

//                 bool isSelected = selectedMonth == index + 1;

//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedMonth = index + 1;
//                     });
//                   },
//                   child: Container(
//                     margin: EdgeInsets.symmetric(
//                         horizontal: 8, vertical: 10),
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? Colors.blue
//                           : Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Center(
//                       child: Text(
//                         months[index],
//                         style: TextStyle(
//                           color: isSelected
//                               ? Colors.white
//                               : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           /// 🔹 LIST
//           Expanded(
//             child: provider.isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : filteredList.isEmpty
//                     ? Center(child: Text("No Attendance"))
//                     : ListView.builder(
//                         itemCount: filteredList.length,
//                         itemBuilder: (context, index) {
//                           final item = filteredList[index];

//                           return buildAttendanceCard(item);
//                         },
//                       ),
//           )
//         ],
//       ),
//     );
//   }

//   ///  CARD UI
//   Widget buildAttendanceCard(AllAttendanceModel item) {

//     Color statusColor;

//     switch (item.status) {
//       case "ABSENT":
//         statusColor = Colors.red;
//         break;
//       case "IS_PRESENT_ERROR":
//         statusColor = Colors.orange;
//         break;
//       default:
//         statusColor = Colors.green;
//     }

//     return Card(
//       margin: EdgeInsets.all(10),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: statusColor,
//           child: Icon(Icons.calendar_today, color: Colors.white),
//         ),
//         title: Text(item.homeCareName),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("City: ${item.city}"),
//             Text("Date: ${item.date}"),
//             Text("Hours: ${item.formattedTotalHours}"),
//           ],
//         ),
//         trailing: Text(
//           item.status,
//           style: TextStyle(color: statusColor),
//         ),
//       ),

//     );
//   }
// }