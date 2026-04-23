class NotificationCountModel {
  final int count;

  NotificationCountModel({
    required this.count,
  });

  factory NotificationCountModel.fromJson(Map<String, dynamic>json){
    return NotificationCountModel(
      count: json['count'],
      );
  }

}