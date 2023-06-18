import 'package:flutter/material.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidable/hidable.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],

          bottomNavigationBar: Hidable(
            controller: cubit.scrollController,
            child: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                iconSize: 22,
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.grey,
                elevation: 0.0,
                onTap: (value) {
                  cubit.changeIndex(value);
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.chat_outlined), label: 'Chats'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.post_add), label: 'Add Post'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_rounded), label: 'Profile'),
                ]),
          ),
        );
      },
    );
  }
}