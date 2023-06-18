import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:socialmedia/models/message_model.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../models/user_model.dart';

class ChatDetails extends StatelessWidget {
  SocialUserModel userModel ;
  ChatDetails(this.userModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      AppCubit.get(context).getMessages(receiverId: userModel.uId);
      return BlocConsumer<AppCubit ,AppState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var textController = TextEditingController();
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 25,
              title: ListTile(
                title: Text(userModel.name ,style: const TextStyle(fontWeight: FontWeight.bold) ,softWrap: true),
                leading: CircleAvatar(
                    backgroundImage:NetworkImage(userModel.image)),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0.0,
            ),
            body: ConditionalBuilder(
                condition:true ,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                            physics:const BouncingScrollPhysics(),
                            itemBuilder: (context, index)
                            {
                              var message = AppCubit.get(context).messages[index];
                              if(message.senderId == userModel.uId) {
                                return buildMessage(message);
                              }
                              return buildMyMessage(message);
                            },
                            separatorBuilder: (context, index) => const SizedBox(height: 5,),
                            itemCount: AppCubit.get(context).messages.length,


                          )),
                      Container(
                        decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          children: [
                            Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    controller: textController,
                                    decoration:const InputDecoration(hintText: 'Type Your Message...',border: OutlineInputBorder()),
                                  ),
                                )
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(topRight: Radius.circular(10) ,bottomRight: Radius.circular(10)),
                                color: Colors.blue[900],

                              ),
                              child: MaterialButton(
                                  onPressed: (){
                                    AppCubit.get(context).sentMessages(
                                      text: textController.text,
                                      dateTime: DateTime.now().toString(),
                                      receiverId: userModel.uId,
                                    );
                                  },
                                  minWidth: 1,
                                  child:const Icon(Icons.send ,color: Colors.white, )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                fallback:(context) => const Center(
                    child: Text('There is no messages yet' ,
                      style: TextStyle(color: Colors.grey),)),
            ),
          );
        },
      );
    },);
  }
}

buildMessage(MessageModel model)
{
  return Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding:const EdgeInsets.symmetric(vertical: 7 ,horizontal:  14),
      decoration:const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(12),
          topStart: Radius.circular(12),
          topEnd: Radius.circular(12),
        ),
      ),
      child: Text(model.text ,softWrap: true , style: const TextStyle(fontSize: 15)),
    ),
  );
}



buildMyMessage(MessageModel model)
{
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding:const EdgeInsets.symmetric(vertical: 7 ,horizontal:  14),
      decoration:const BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(12),
          topStart: Radius.circular(12),
          topEnd: Radius.circular(12),
        ),
      ),
      child: Text(model.text ,softWrap: true , style: const TextStyle(fontSize: 15)),
    ),
  );
}