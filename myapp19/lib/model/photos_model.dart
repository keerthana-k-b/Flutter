class PhotosModel {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumnailUrl;

  PhotosModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumnailUrl,
  });

  factory PhotosModel.fromJson(Map<String, dynamic> json){
    return PhotosModel(
      albumId: json['albumId'] ?? '', 
      id: json['id'] ?? '', 
      title: json['title'] ?? '', 
      url: json['url'] ?? '', 
      thumnailUrl: json['thumnailUrl'] ?? '',
      );
  }
}