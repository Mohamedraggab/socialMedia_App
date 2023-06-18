import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class AddComment extends StatelessWidget {
  String postId ;
  AddComment(this.postId , {super.key});

  @override
  Widget build(BuildContext context) {
    var commentController = TextEditingController();

    return BlocConsumer<AppCubit ,AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> comment = AppCubit.get(context).comment ;
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ConditionalBuilder(
                  condition: comment.isNotEmpty,
                  builder: (context) => ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index)
                      {
                        return Card(
                          color: Colors.white70,
                          margin:const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(backgroundImage: NetworkImage(comment[index]['image']),),
                                    const SizedBox(width: 5,),
                                    Text(comment[index]['name'] , style: const TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 8,),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('${comment[index]['text']}'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder:(context, index) => const SizedBox(height: 3,),
                      itemCount: comment.length
                  ),
                  fallback: (context) =>const Center(child: CircularProgressIndicator()),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0 ,bottom: 8.0 ,top: 8.0),
                      child: TextFormField(
                        controller: commentController,
                        decoration:const InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                            hintText: 'Write a Comment'),
                      ),
                    ),
                  ),
                  IconButton(onPressed: ()
                  {
                    AppCubit.get(context).addComment(postUId: postId,comment: commentController.text);
                    commentController.clear();
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.send , color: Colors.blue),)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
