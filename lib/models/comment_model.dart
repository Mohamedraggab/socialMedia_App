class CommentModel {
  late String text ;
  late String dateTime ;
  late String postUId ;
  late String userId ;
  late String image ;
  late String name ;

  CommentModel({
    required this.text,
    required this.dateTime,
    required this.postUId,
    required this.userId,
    required this.image,
    required this.name,

  }) ;

  CommentModel.fromJson(Map<String , dynamic> json)
  {
    text = json['text'];
    dateTime = json['dateTime'];
    postUId = json['postUId'];
    userId = json['userId'];
    image = json['image'];
    name = json['name'];

  }

  Map<String , dynamic> toMap ()
  {
    return {
      'text': text ,
      'dateTime': dateTime ,
      'postUId': postUId ,
      'userId': userId ,
      'image': image ,
      'name': name ,

    } ;
  }


}