import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:socialmedia/models/user_model.dart';
import 'package:socialmedia/screens/chat_details.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit ,AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title:const Text('Chat'),
            elevation: 0.0,
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
            ],
          ),
          body:ListView.separated(
              itemBuilder: (context, index) => buildChatScreen(context: context, mod: cubit.allUsers[index]),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Divider(),
              ),
              itemCount: cubit.allUsers.length),
        );
      },
    );
  }
}



Widget buildChatScreen({
  required SocialUserModel mod ,
  required  BuildContext context,
})
{
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetails(mod),));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0 ,vertical: 2),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(mod.image),
        ),
        title: Text(mod.name , style:const TextStyle(fontWeight: FontWeight.bold)),
      ),
    ),
  );
  
}
