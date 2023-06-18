import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:socialmedia/shared/constants.dart';
class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit ,AppState>(
      listener: (context, state) {
        if(state is CreatePostSuccessAppState)
          {
            AppCubit.get(context).removePhoto();
            AppCubit.get(context).getPosts();
          }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var now = DateTime.now().toString();
        var textController = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title:const Text('Create post'),
            elevation: 0.0,
            actions: [
              TextButton(
                  onPressed: (){
                    if(cubit.postImage != null) {
                      cubit.uploadPostImage(post: textController.text);
                    }
                    else {
                      cubit.createPost(post: textController.text);
                    }
                  },
                  child:const Text('Post',style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 18),)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //////////post header /////////////////
                Row(
                  children: [
                    Padding(
                      padding:const EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(userdata!.image)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Padding(
                          padding:const EdgeInsets.only(bottom: 5.0),
                          child: Text(userdata!.name ,
                              style:const TextStyle(fontWeight: FontWeight.bold ,color: Colors.black)),
                        ),
                        Text(now,
                            style: const TextStyle(
                              color: Colors.grey ,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 5,),
                if(state is CreatePostAppState)
                  const LinearProgressIndicator(),
                ////// add post white space area //////
                 Expanded(
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.text,
                    decoration:const  InputDecoration(
                      hintText: "What's in your mind...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(cubit.postImage != null)
                  Stack(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(cubit.postImage)),
                          )
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(onPressed: (){
                          cubit.removePhoto();
                        }, icon: const Icon(Icons.close)),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: (){
                        cubit.addPhoto();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:const [
                          Icon(Icons.photo),
                          Text('Add Photo'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
