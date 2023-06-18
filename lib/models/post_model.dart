class PostModel {
  late String name ;
  late String uId  ;
  late String postImage  ;
  late String profileImage  ;
  late String post  ;
  late String timeDate  ;

  PostModel({
    required this.name,
    required this.postImage,
    required this.profileImage,
    required this.uId,
    required this.post,
    required this.timeDate,

  }) ;

  PostModel.fromJson(Map<String , dynamic>? json)
  {
    name = json!['name'];
    postImage = json['postImage'];
    profileImage = json['profileImage'];
    uId = json['uId'];
    post = json['post'];
    timeDate = json['timeDate'];


  }

  Map<String , dynamic> toMap ()
  {
    return {
      'name': name ,
      'post': post ,
      'postImage': postImage ,
      'uId': uId ,
      'profileImage': profileImage ,
      'timeDate': timeDate ,
    } ;
  }


}