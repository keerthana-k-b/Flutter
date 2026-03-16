class AlbumModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      userId: json['userId'], 
      id: json['id'], 
      title: json['title'], 
      body: json['body']
      );
  }
}
