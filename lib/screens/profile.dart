import 'package:flutter/material.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/screens/edit.dart';
import 'package:socialmedia/shared/constants.dart';

import '../login&&register/login.dart';
import '../shared/local/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if(state is InitAppState)
          {
            AppCubit.get(context).getUserData();
          }
        },
        builder: (context, state) {
          var updatedName = TextEditingController();
          var updatedBio = TextEditingController();
          var updatedPhone = TextEditingController();
          var cubit = AppCubit.get(context);
          updatedName.text = userdata!.name;
          updatedBio.text = userdata!.bio;
          updatedPhone.text = userdata!.phone;
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              title:const Text('Profile'),
              elevation: 0.0,
              actions: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
////////////////// cover and image///////////////////
                  SizedBox(
                    height: 240,
                    child: Stack(
                      children: [
/////////////////////////////////// cover ///////////////////////
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: cubit.coverImage == null
                                      ? NetworkImage(userdata!.cover)
                                      : FileImage(cubit.coverImage)
                                          as ImageProvider,
                                ),
                              ),
                            ),
                            //cover picker
                          ],
                        ),
/////////////////////////////////// image ///////////////////////
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 75,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: cubit.profileImage == null
                                      ? NetworkImage(userdata!.image)
                                      : FileImage(cubit.profileImage)
                                          as ImageProvider,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
////////////////////////// Name and bio ///////////////////////////////
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 6, top: 0),
                        child: Text(userdata!.name,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 6, top: 0),
                        child: Text(userdata!.bio,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ],
                  ),
                  /////////////////////////////////////////////////////////////////////
                  /////////////////////////////////////////////////////////////////////
                  //////////////////////////Update Profile/////////////////////////////
                  /////////////////////////////////////////////////////////////////////
                  /////////////////////////////////////////////////////////////////////

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>const EditScreen(),));
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return Center(
                    child: Container(
                      width: 250,
                      height: 100,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Want to Sign out? ',
                              style: TextStyle(
                                  fontFamily: AutofillHints.oneTimeCode,
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    CacheHelper.logout(key: 'uId');
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const LoginScreen(),
                                        ),
                                            (route) => false);
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(fontSize: 20),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } ,child: const Icon(Icons.logout)),
          );
        });
  }
}