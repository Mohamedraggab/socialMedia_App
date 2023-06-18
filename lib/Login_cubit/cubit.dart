import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/models/comment_model.dart';
import 'package:socialmedia/models/message_model.dart';
import 'package:socialmedia/screens/search.dart';
import 'package:socialmedia/shared/constants.dart';
import '../models/post_model.dart';
import '../screens/add_post.dart';
import '../screens/chat.dart';
import '../screens/home.dart';
import '../screens/profile.dart';
import 'states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmedia/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_firestore ;
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppState>
{
  AppCubit() : super(InitAppState()) ;

  static AppCubit get(context) => BlocProvider.of(context);

//////////////login method with firebase ////////////


  final ScrollController scrollController = ScrollController();

  var currentIndex = 0 ;
  void changeIndex(int index)
  {
    if(index == 1) {
      getAllUsers();
    }
    currentIndex = index ;
    emit(ChangeIndexLayoutState());
  }


  var screens = const [
    HomeScreen(),
    ChatScreen(),
    AddPost(),
    ProfileScreen()
  ];


  dynamic profileImage ;
  dynamic coverImage ;
  var picker = ImagePicker();

  Future<void> getProfileImage()async
  {
    emit(GetImageLayoutState());
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if(pickedImage != null)
    {
      profileImage = File(pickedImage.path);
      emit(GetImageSuccessLayoutState());
    }
    else
    {
      emit(GetImageErrorLayoutState());
      //print('No Image Selected');
    }
  }

  Future<void> getCoverImage() async
  {
    emit(GetCoverLayoutState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null)
    {
      coverImage = File(pickedFile.path);
      emit(GetCoverSuccessLayoutState());
    }
    else
    {
      emit(GetCoverErrorLayoutState());
      //print('No Image Selected');
    }
  }



  void uploadProfileImage(
      {
        required String name ,
        required String bio ,
        required String phone ,
      }
      )
  {
    emit(UploadImageLayoutState());
    firebase_firestore.FirebaseStorage.instance
        .ref()
        .child('usersProfiles/${Uri.file(profileImage.path).pathSegments.last}')
        .putFile(profileImage)
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
        updateProfile(name: name, phone: phone, bio: bio ,image: value);

      }).catchError((error){
        emit(UploadImageErrorLayoutState());
      });
    })
        .catchError((error){});
  }



  void uploadCoverImage(
  {
    required String name ,
    required String bio ,
    required String phone ,
}
      )
  {
    emit(UploadCoverLayoutState());
    firebase_firestore.FirebaseStorage.instance
        .ref()
        .child('usersCover/${Uri.file(coverImage.path).pathSegments.last}')
        .putFile(coverImage)
        .then((value){
      value.ref.getDownloadURL()
          .then((value){
        updateCover(name: name, phone: phone, bio: bio ,cover: value);
      }).catchError((error){
        emit(UploadCoverErrorLayoutState());
      });
    }).catchError((error){});
  }

  void updateUser(
      {
        required String name ,
        required String phone ,
        required String bio ,
      }
      )
  {

    SocialUserModel model = SocialUserModel(
      name: name ,
      phone: phone ,
      bio: bio,
      email: userdata!.email ,
      uId: (FirebaseAuth.instance.currentUser)!.uid,
      image: userdata!.image ,
      cover: userdata!.cover,
    );
    emit(UpdateUserLayoutState());
    FirebaseFirestore.instance.collection('users')
        .doc((FirebaseAuth.instance.currentUser)!.uid)
        .update(model.toMap())
        .then((value)
    {
      emit(UpdateUserSuccessLayoutState());
      getUserData();
    }).catchError((error){
      emit(UpdateUserErrorLayoutState());
    });

  }



  void updateProfile(
      {
        required String name ,
        required String phone ,
        required String bio ,
        required String image ,
      }
      )
  {

    SocialUserModel model = SocialUserModel(
      name: name ,
      phone: phone ,
      bio: bio,
      email: userdata!.email ,
      uId: (FirebaseAuth.instance.currentUser)!.uid,
      image: image ,
      cover: userdata!.cover,
    );
    emit(UpdateUserProfileLayoutState());
    FirebaseFirestore.instance.collection('users')
        .doc((FirebaseAuth.instance.currentUser)!.uid)
        .update(model.toMap())
        .then((value)
    {
      emit(UpdateUserProfileSuccessLayoutState());
      getUserData();
      profileImage = null ;
    }).catchError((error){
      emit(UpdateUserProfileErrorLayoutState());
    });

  }



  void updateCover(
      {
        required String name ,
        required String phone ,
        required String bio ,
        required String cover ,
      }
      )
  {

    SocialUserModel model = SocialUserModel(
      name: name ,
      phone: phone ,
      bio: bio,
      email: userdata!.email ,
      uId: (FirebaseAuth.instance.currentUser)!.uid,
      image: userdata!.image ,
      cover: cover ,
    );
    emit(UpdateUserCoverLayoutState());
    FirebaseFirestore.instance.collection('users')
        .doc((FirebaseAuth.instance.currentUser)!.uid)
        .update(model.toMap())
        .then((value)
    {
      emit(UpdateUserCoverLayoutState());
      getUserData();
      coverImage = null ;
    }).catchError((error){
      emit(UpdateUserCoverErrorLayoutState());
    });

  }












  createUser({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }){
    emit(CreateUserAppState());
    userdata  = SocialUserModel(
        name: name ,
        email: email ,
        phone: phone ,
        uId: uId,
        image:'https://as1.ftcdn.net/v2/jpg/01/25/11/64/1000_F_125116470_wClwGpNIwmElCIgbtV6OYcL5HPWYXZjJ.jpg',
        cover: 'https://img.freepik.com/free-photo/beach-with-umbrella-summer-vacation-concept-generative-ai_60438-2518.jpg?w=1380&t=st=1685024907~exp=1685025507~hmac=8065ac6a2c97a77390b71848ef74da906d3ed56eb0ed98ebf1634b6faa9365fa' ,
        bio: 'Write Bio ...',
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(userdata!.toMap()).then((value)
    {
      emit(CreateUserSuccessAppState());
    }).catchError((error)
    {
      emit(CreateUserErrorAppState());
    });
  }

userLogin(
  {
    required String email ,
    required String password ,
  }
    )
{
  emit(LoginAppState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
  ).then((value)
  {
    emit(LoginSuccessAppState());
    getUserData();
  }).catchError((error){
    emit(LoginErrorAppState());
  });
}


userRegister(
  {
    required String username,
    required String email,
    required String password,
    required String phone,
}
    )
{
  emit(RegisterAppState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
  ).then((value){
    emit(RegisterSuccessAppState());
    createUser(
        name: username,
        email: email,
        phone: phone,
        uId: value.user!.uid );

  }).catchError((error)
  {
    emit(RegisterErrorAppState());
  });
}

////////////////////////get user data ///////////

getUserData()
{
  emit(GetUserAppState());
  FirebaseFirestore
      .instance
      .collection('users')
      .doc((FirebaseAuth.instance.currentUser!).uid)
      .get()
      .then((value){
        userdata = SocialUserModel.fromJson(value.data());
        emit(GetUserSuccessAppState(
            (FirebaseAuth.instance.currentUser!).uid
        ));
  })
      .catchError((error){
    emit(GetUserErrorAppState());
  });

}


///////////add post /////////////////

  dynamic postImage;


Future<void> addPhoto()async
{
  emit(UploadPostImageLayoutState());
  final pickedFile =  await picker.pickImage(source: ImageSource.gallery);

  if(pickedFile != null)
  {
    postImage = File(pickedFile.path);
    emit(UploadPostImageSuccessLayoutState());
  }

  else
  {
    print('No image selected');
    emit(UploadPostImageErrorLayoutState());
  }
}


uploadPostImage({
    required String post,
})
{
  emit(CreatePostImageAppState());
  firebase_firestore.FirebaseStorage.instance.ref()
      .child('post/${Uri.file(postImage.path).pathSegments.last}')
      .putFile(postImage)
      .then((value){
        value.ref.getDownloadURL().then((value){
          createPost(
            post: post,
            postImage: value,
          );
        }).catchError((error){
          emit(CreatePostImageErrorAppState());

        });
  }).catchError((error){
    emit(CreatePostImageErrorAppState());

  });
}



  var dateTime = DateTime.now().toString();


createPost({
    String? postImage,
    required String post,
})
{
  PostModel modelPost = PostModel(
      name: userdata!.name,
      postImage: postImage??'',
      profileImage: userdata!.image,
      uId: userdata!.uId,
      post: post,
      timeDate: dateTime
  );
  emit(CreatePostAppState());
  FirebaseFirestore.instance.collection('posts')
      .add(modelPost.toMap())
      .then((value){
    emit(CreatePostSuccessAppState());
  })
      .catchError((error){
    emit(CreatePostErrorAppState());
  });

}



removePhoto()
{
  postImage = null ;
  emit(RemovePostImageAppState());
}



List<PostModel> posts = [] ;
List<String> postsUId = [] ;
List<int> likes = [] ;
List<dynamic> comment = [] ;


 getPosts()
 {
   posts = [];
   comment = [] ;
   emit(GetPostsLayoutState());
   FirebaseFirestore.instance.collection('posts').get()
       .then((value){
         for (var element in value.docs) {
           element.reference.collection('like')
               .get()
               .then((value){
             posts.add(PostModel.fromJson(element.data()));
             postsUId.add(element.id);
             likes.add(value.docs.length);
           })
               .catchError((error){});
         }
         ///////////////////////////
         for (var element in value.docs) {
           element.reference.collection('comment')
               .get()
               .then((value){
             for (var element in value.docs)
             {
               comment.add(element.data());
               print('///////////////////////////////${element.data()}');
             }
           })
               .catchError((error){});
         }
         emit(GetPostsSuccessLayoutState());
   })
       .catchError((error){
         emit(GetPostsErrorLayoutState());
   });

 }




  addLike(String postUId)
  {
    emit(LikePostsLayoutState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postUId)
        .collection('like')
        .doc(userdata!.uId)
        .set({'like' : true})
        .then((value){
          emit(LikePostsSuccessLayoutState());
    }).catchError((error){
      emit(LikePostsErrorLayoutState());
    });
  }


  addComment({required String postUId ,required String comment})
  {
    var cModel = CommentModel(text: comment, dateTime: TimeOfDay.now().toString(),
        postUId: postUId, image: userdata!.image,
    name: userdata!.name,
        userId: userdata!.uId,);
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postUId)
        .collection('comment')
        .add(cModel.toMap())
        .then((value){
      emit(CommentGetSuccessLayoutState());
      getPosts();
    }).catchError((error){
      emit(CommentGetErrorLayoutState());
    });
  }





  List<SocialUserModel> allUsers = [] ;


  getAllUsers()
  {
    allUsers = [];
    emit(GetAllUsersState());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value){
          for (var element in value.docs) {
            if(element.data()['uId'] != userdata!.uId) {
              allUsers.add(SocialUserModel.fromJson(element.data()));
            }
          }
          emit(GetAllUsersSuccessState());
        })
        .catchError((error){
          emit(GetAllUsersErrorState());
    });
  }


  
  sentMessages({
    required String text,
    required String dateTime,
    required String receiverId,
})
  {
    MessageModel model = MessageModel(
        text: text,
        dateTime: dateTime,
        receiverId: receiverId,
        senderId: userdata!.uId);
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userdata!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
          emit(SendMessageSuccessState());
          //getMessages();
    })
        .catchError((error){
          emit(SendMessageErrorState());
    });

    FirebaseFirestore
        .instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userdata!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((error){
      emit(SendMessageErrorState());
    });
  }
  


  List<MessageModel> messages = [];

  getMessages({required String receiverId})
  {
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userdata!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection("messages")
        .orderBy('dateTime')
        .snapshots()
        .listen((event){
          messages = [];
          for (var element in event.docs) {
            messages.add(MessageModel.fromJson(element.data()));
          }
          emit(GetMessageSuccessState());
    });


  }




  searchButton({
    required context,
})
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(),));
    emit(SearchAppState());
  }


var searchedPosts = [];
search({required String text})
{
  searchedPosts = [];
  posts.forEach((element) {
    if(element.post.contains(text))
    {
      searchedPosts.add(element);
      emit(SearchSuccessAppState());
      print(element.post);
    }
  });
}


  }