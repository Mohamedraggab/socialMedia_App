import 'package:flutter/material.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:socialmedia/screens/add_comments.dart';
import 'package:socialmedia/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<AppCubit ,AppState>(
      listener: (context, state) {},
        builder: (context, state) {
        var cubit = AppCubit.get(context);
        var commentController = TextEditingController();
        var posts = cubit.posts;
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title:const Text('Feeds'),
            elevation: 0.0,
            actions: [
              IconButton(onPressed: (){
                cubit.searchButton(context: context);
              }, icon: const Icon(Icons.search)),
            ],
          ),
            body: ConditionalBuilder(
                condition: posts.isNotEmpty && userdata != null,
                builder: (context) => ListView.builder(
                  controller: cubit.scrollController,
                  itemBuilder:
                      (context ,index )=>
                      customPost(
                        commentController: commentController,
                        likes: cubit.likes[index],
                        postUId: cubit.postsUId[index],
                        context: context,
                        image: posts[index].postImage,
                        name: posts[index].name,
                        dateTime: posts[index].timeDate,
                        post: posts[index].post,
                        profileImage: posts[index].profileImage,
                      ),
                  itemCount: posts.length,
                  physics: const BouncingScrollPhysics(),
                ),
                fallback: (context) =>const Center(child: CircularProgressIndicator()),),

          );
        },
        );
  }
}


//////post Design//////////


Widget customPost(
    {
      required String image ,
      required String post ,
      required String profileImage ,
      required String name ,
      required BuildContext context ,
      required String postUId ,
      required int likes ,
      required String dateTime,
      required TextEditingController commentController ,
    } )
{
  return Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: const EdgeInsets.symmetric(vertical: 5),
    shape:const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    elevation: 5,
    color: Colors.white,
    child: Column(
        children: [
          /////////////////////////////post header ////////////////////////
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding:const EdgeInsets.only(right: 15,),
                  child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(profileImage)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(name ,style: const TextStyle(fontWeight: FontWeight.bold ,color: Colors.black)),
                    ),
                    Text(dateTime ,
                        style:const TextStyle(
                          color: Colors.grey ,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ],
            ),
          ), //title
          /////////////////////////////post content ////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(post ,
                    style:const TextStyle(fontWeight: FontWeight.bold ,)),
              ), //post text
              if(image != '')
                Center(
                  child: Container(
                      width: double.infinity,
                      height: 270,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(image))
                      )
                  ),
                ), // post pic
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white,) ,
                    elevation:MaterialStatePropertyAll(0.0) ,
                  ),
                  onPressed: (){},
                  child: Row(
                    children: [
                      const Icon(
                        Icons.favorite_border_outlined ,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      Text(' $likes' ,style: const TextStyle(color: Colors.redAccent ,fontSize: 14 )),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white,) ,
                    elevation:MaterialStatePropertyAll(0.0) ,
                  ),
                  onPressed: (){},
                  child: Row(
                    children:const [
                      Icon(
                        Icons.comment ,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      Text(' Comments' ,style: TextStyle(color: Colors.redAccent ,fontSize: 14 )),
                    ],
                  ),
                ),
              ]), // comments and like
          const Divider(
            height: 1,
          ),
          ListTile(
            style: ListTileStyle.drawer,
            trailing: IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).addLike(postUId);
                },
                icon: const Icon(Icons.favorite_border_outlined)),
            leading: CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(profileImage),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                    style: const ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddComment(postUId),));
                      AppCubit.get(context).getPosts();
                    },
                    child:const Text('Write Comment..' ,
                      style: TextStyle(color: Colors.grey),)),
              ],
            ),
          ),


        ]),
  );
}