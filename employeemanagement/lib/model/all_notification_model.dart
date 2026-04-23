class AllNotificationModel {
  final int id;
  final String title;
  final String date;
  final String description;
  final String status;
  final String category;
  final String? createdAt;
  final int? specificId;
  final String? redirectTo;
  final bool read;
  final bool redirected;

  AllNotificationModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.status,
    required this.category,
    this.createdAt,
    this.specificId,
    this.redirectTo,
    required this.read,
    required this.redirected,
  });

  factory AllNotificationModel.fromJson(Map<String, dynamic> json) {
    return AllNotificationModel(
      id: json['id'], 
      title: json['title'] ?? "", 
      date: json['date'] ?? "", 
      description: json['description'] ?? "", 
      status: json['status'] ?? "", 
      category: json['category'] ?? "", 
      createdAt: json['createdAt'],
      specificId: json['specificId'],
      redirectTo: json['redirectTo'],
      read: json['read'] ?? false, 
      redirected: json['redirected'] ?? false,
      );
  }
}