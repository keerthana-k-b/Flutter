class AdminAvailabilityModel {
  final int availabilityId;
  final String date;
  final String studentName;
  final String? homeCareName;
  final String? city;
  final bool assigned;
  final bool accepted;
  final bool requested;
  final String requestFrom;

  AdminAvailabilityModel({
    required this.availabilityId,
    required this.date,
    required this.studentName,
    this.homeCareName,
    this.city,
    required this.assigned,
    required this.accepted,
    required this.requested,
    required this.requestFrom,
  });

  factory AdminAvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AdminAvailabilityModel(
      availabilityId: json['availabilityId'],
      date: json['date'],
      studentName: json['studentName'] ?? "",
      homeCareName: json['homeCareName'],
      city: json['city'],
      assigned: json['assigned'] ?? false,
      accepted: json['accepted'] ?? false,
      requested: json['requested'] ?? false,
      requestFrom: json['requestFrom'] ?? "",
    );
  }
}