class AllAttendanceModel {
  final int attendanceId;
  final String date;
  final String? checkIn;
  final String? checkOut;
  final int totalMinutes;
  final String totalHours;
  final String city;
  final String homeCareName;
  final String status;
  final String formattedTotalHours;

  AllAttendanceModel({
    required this.attendanceId,
    required this.date,
    this.checkIn,
    this.checkOut,
    required this.totalMinutes,
    required this.totalHours,
    required this.city,
    required this.homeCareName,
    required this.status,
    required this.formattedTotalHours,
  });

  factory AllAttendanceModel.fromJson(Map<String, dynamic> json){
    return AllAttendanceModel(
      attendanceId: json['attendanceId'], 
      date: json['date'] ?? "", 
      checkIn: json['checkInTime'] ?? json['checkIn'],
      checkOut: json['checkOut'],
      totalMinutes: json['totalMinutes'] ?? 0, 
      totalHours: json['totalHours'] ?? "0:00", 
      city: json['city'] ?? "", 
      homeCareName: json['homeCareName'] ?? "", 
      status: json['status'] ?? "", 
      formattedTotalHours: json['formattedTotalHours'] ?? "0:00",
      );
  }
}