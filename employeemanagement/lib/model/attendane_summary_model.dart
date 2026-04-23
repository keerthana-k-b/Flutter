class AttendanceSummaryModel {
  final int totalAbsent;
  final int totalPresent;
  final int totalUpComingWork;
  final int totalPresentHours;

  AttendanceSummaryModel({
    required this.totalAbsent,
    required this.totalPresent,
    required this.totalUpComingWork,
    required this.totalPresentHours,
  });

  factory AttendanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return AttendanceSummaryModel(
      totalAbsent: json['totalAbsent'] ?? 0,
      totalPresent: json['totalPresent'] ?? 0,
      totalUpComingWork: json['totalUpComingWork'] ?? 0,
      totalPresentHours: json['totalPresentHours'] ?? 0,
    );
  }
}