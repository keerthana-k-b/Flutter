class AttendanceDetailModel {
  final int attendanceId;
  final String date;
  final String city;
  final String homeCareName;
  final String status;
  final String fullAddress;

  AttendanceDetailModel({
    required this.attendanceId,
    required this.date,
    required this.city,
    required this.homeCareName,
    required this.status,
    required this.fullAddress,
  });

  factory AttendanceDetailModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailModel(
      attendanceId: json['attendanceId'],
      date: json['date'],
      city: json['city'],
      homeCareName: json['homeCareName'],
      status: json['status'],
      fullAddress: json['fullAddress'] ?? "",
    );
  }
}