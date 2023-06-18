import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var textController = TextEditingController();
    return BlocConsumer<AppCubit ,AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: Center(
              child: TextFormField(
                controller: textController,
                onChanged: (value) => cubit.search(text: textController.text),
                decoration:const InputDecoration(
                    hintText: 'Search',
                    border:InputBorder.none
                ),
              ),
            ),
            titleSpacing: 8,
          ),
          body: ConditionalBuilder(
            condition: cubit.searchedPosts.isNotEmpty ,
            builder: (context) => ListView.builder(
              itemBuilder:
                  (context ,index )=>
                  customPost(
                    likes: cubit.likes[index],
                    postUId: cubit.postsUId[index],
                    context: context,
                    image: cubit.searchedPosts[index].postImage,
                    name: cubit.searchedPosts[index].name,
                    dateTime: cubit.searchedPosts[index].timeDate,
                    post: cubit.searchedPosts[index].post,
                    profileImage: cubit.searchedPosts[index].profileImage,
                  ),
              itemCount: cubit.searchedPosts.length,
              physics: const BouncingScrollPhysics(),
            ),
            fallback: (context) =>const Center(child: CircularProgressIndicator()),),
        );
      },
      
    );
  }
}



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
                    onPressed: (){},
                    child:const Text('Write Comment..' ,
                      style: TextStyle(color: Colors.grey),)),
              ],
            ),
          ),


        ]),
  );
}
