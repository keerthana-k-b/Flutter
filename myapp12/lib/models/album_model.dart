class AlbumModel{    //model
  final int userId;  //key
  final int id;
  final String title;
  
  AlbumModel({    //constructor
    required this.userId,
    required this.id,
    required this.title,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json){
    return AlbumModel(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      );
  }

}