import 'package:employeemanagement/model/student_availability_model.dart';
import 'package:employeemanagement/provider/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({super.key});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  DateTime focusedDay = DateTime.now();
  Set<DateTime> selectedDates = {};
  Map<DateTime, StudentAvailabilityModel> savedDates = {};
  bool isSubmitting = false;

  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  void initState() {
    super.initState();
    loadSavedDates();
  }

  void loadSavedDates() async {
    final provider =
        Provider.of<EmployeeProvider>(context, listen: false);

    await provider.loadToken();
    List<StudentAvailabilityModel> data =
        await provider.fetchAvailability();

    if (!mounted) return;

    setState(() {
      savedDates = {
        for (var item in data)
          normalizeDate(DateTime.parse(item.date)): item
      };
    });
  }

  Widget statusBox(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Set Availability",
          style: TextStyle(color: Colors.blue),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 10),

            /// 🔹 STATUS SECTION
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                  )
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: statusBox(Colors.green, "Assigned Jobs")),
                      Expanded(child: statusBox(Colors.blue, "Your Request")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: statusBox(Colors.red, "Undo Requests")),
                      Expanded(child: statusBox(Colors.yellow, "Care Home Request")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: statusBox(const Color(0xFF1D5380), "Selected")),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// 🔹 CALENDAR
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime(2027),
                focusedDay: focusedDay,

                /// FIX 2 WEEK ISSUE
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
                calendarFormat: CalendarFormat.month,

                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  leftChevronIcon:
                      const Icon(Icons.chevron_left, color: Colors.blue),
                  rightChevronIcon:
                      const Icon(Icons.chevron_right, color: Colors.blue),
                ),

                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(fontSize: 12),
                  weekendStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),

                selectedDayPredicate: (day) {
                  return selectedDates.contains(normalizeDate(day));
                },

                onDaySelected: (selectedDay, focusedDay) {
                  final normalized = normalizeDate(selectedDay);

                  if (savedDates.containsKey(normalized)) return;

                  setState(() {
                    if (selectedDates.contains(normalized)) {
                      selectedDates.remove(normalized);
                    } else {
                      selectedDates.add(normalized);
                    }
                    this.focusedDay = focusedDay;
                  });
                },

                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),

                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    final text = ['S','M','T','W','T','F','S'][day.weekday % 7];

                    return Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: day.weekday == DateTime.sunday
                              ? Colors.red
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },

                  defaultBuilder: (context, day, focusedDay) {
                    final normalized = normalizeDate(day);

                    if (savedDates.containsKey(normalized)) {
                      final data = savedDates[normalized]!;

                      Color color;

                      if (data.assigned) {
                        color = Colors.green;
                      } else if (data.requested) {
                        color = Colors.blue;
                      } else if (!data.accepted) {
                        color = Colors.red;
                      } else {
                        color = const Color(0xFF1B5381);
                      }

                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),


            ///  SELECTED DATES VIEW 
if (selectedDates.isNotEmpty)
  Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Wrap(
      spacing: 8,
      runSpacing: 8,
      children: selectedDates.map((date) {
        final formatted =
            "${date.day}/${date.month}/${date.year}";

        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.blue),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formatted,
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 6),

              /// ❌ REMOVE BUTTON
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDates.remove(date);
                  });
                },
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  ),

            /// 🔹 BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: (selectedDates.isEmpty || isSubmitting)
                    ? null
                    : () async {
                        setState(() => isSubmitting = true);

                        List<String> formattedDates =
                            selectedDates.map((date) {
                          return "${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}";
                        }).toList();

                        final provider = Provider.of<EmployeeProvider>(
                            context,
                            listen: false);

                        await provider.loadToken();

                        bool success =
                            await provider.setAvailability(formattedDates);

                        if (success) {
                          setState(() {
                            for (var date in selectedDates) {
                              savedDates[date] =
                                  StudentAvailabilityModel(
                                date:
                                    "${date.year}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')}",
                                assigned: false,
                                accepted: true,
                                requested: false,
                                requestFrom: "USER",
                              );
                            }
                            selectedDates.clear();
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Saved Successfully")),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Failed to save")),
                          );
                        }

                        setState(() => isSubmitting = false);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: isSubmitting
                    ? const CircularProgressIndicator(
                        color: Colors.white)
                    : Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: const [
                          Text("Select Dates to Continue"),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}