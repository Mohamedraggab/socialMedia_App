class SocialUserModel {

  late String name;
  late String email;
  late String phone;
  late String uId;
  late String bio;
  late String cover;
  late String image;

  SocialUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.bio,
    required this.cover,
    required this.image,
}) ;

  SocialUserModel.fromJson(Map<String , dynamic>? json)
  {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    bio = json['bio'];
    cover = json['cover'];
    image = json['image'];
  }

  Map<String , dynamic> toMap ()
  {
    return {
      'name': name ,
      'email': email ,
      'phone': phone ,
      'uId': uId ,
      'bio': bio ,
      'cover': cover ,
      'image': image ,
    } ;
  }

}