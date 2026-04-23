class StudentAvailabilityModel {
  final String date;
  final bool assigned;
  final bool accepted;
  final bool requested;
  final String requestFrom;

  StudentAvailabilityModel({
    required this.date,
    required this.assigned,
    required this.accepted,
    required this.requested,
    required this.requestFrom,
  });

  factory StudentAvailabilityModel.fromJson(Map<String, dynamic> json){
    return StudentAvailabilityModel(
      date: json['date'], 
      assigned: json['assigned'] ?? false, 
      accepted: json['accepted'] ?? false, 
      requested: json['requested'] ?? false, 
      requestFrom: json['requestFrom'] ?? "",
      );
  }
}