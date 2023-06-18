import 'package:flutter/material.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/screens/layout.dart';
import 'package:socialmedia/shared/constants.dart';
class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
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
                leading: IconButton(
                    onPressed: ()
                    {
                      Navigator.pushAndRemoveUntil(context ,MaterialPageRoute(builder: (context) =>const Layout(),) ,(route) => false,);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                actions: [
                  TextButton(
                      onPressed: () {
                        ///////////////////////////////////////////
                        ///////////////updateUserData////////////
                        ///////////////////////////////////////
                        cubit.updateUser(
                            name: updatedName.text,
                            phone: updatedPhone.text,
                            bio: updatedBio.text,
                        );
                      },
                      child: const Text('Update' ,softWrap: true , style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),)),
                ],
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    if(state is UploadCoverLayoutState || state is UploadImageLayoutState || state is UpdateUserLayoutState)
                      const LinearProgressIndicator(),
                    /////////////cover and image////////
                    SizedBox(
                      height: 240,
                      child: Stack(
                        alignment:
                        Alignment.bottomCenter,
                        children: [
/////////////////////////////////// cover ///////////////////////
                          Stack(
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration:
                                BoxDecoration(
                                  image:
                                  DecorationImage(
                                    fit: BoxFit.cover,
                                    image: cubit.coverImage ==
                                        null
                                        ? NetworkImage(
                                        userdata!
                                            .cover)
                                        : FileImage(cubit
                                        .coverImage)
                                    as ImageProvider,
                                  ),
                                ),
                              ),
                              Align(
                                alignment:
                                Alignment.topRight,
                                child: Padding(
                                  padding:
                                  const EdgeInsets
                                      .all(12.0),
                                  child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                      Colors.blue,
                                      child: IconButton(
                                          onPressed:
                                              () {
                                            cubit
                                                .getCoverImage();
                                          },
                                          icon:
                                          const Icon(
                                            Icons
                                                .camera_alt_outlined,
                                            color: Colors
                                                .white,
                                          ))),
                                ),
                              ), //cover picker
                            ],
                          ),
/////////////////////////////////// image ///////////////////////
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Stack(
                              alignment:
                              Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                  Colors.white,
                                  radius: 75,
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundImage: cubit
                                        .profileImage ==
                                        null
                                        ? NetworkImage(
                                        userdata!
                                            .image)
                                        : FileImage(cubit
                                        .profileImage)
                                    as ImageProvider,
                                  ),
                                ),
                                Positioned(
                                  left: 100,
                                  child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                      Colors.blue,
                                      child: IconButton(
                                          onPressed:
                                              () {
                                            cubit
                                                .getProfileImage();
                                          },
                                          icon:
                                          const Icon(
                                            Icons
                                                .camera_alt_outlined,
                                            color: Colors
                                                .white,
                                          ))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if(cubit.profileImage != null || cubit.coverImage != null)
                      Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          if(cubit.profileImage != null && cubit.coverImage == null)
                            Expanded(child: ElevatedButton(
                                onPressed: (){
                                  cubit.uploadProfileImage(name: updatedName.text, bio: updatedBio.text, phone: updatedPhone.text);
                                },
                                child:const Text('Update Image'))),
                          if(cubit.coverImage != null && cubit.profileImage == null)
                            Expanded(child: ElevatedButton(
                                onPressed: (){
                                  cubit.uploadCoverImage(name: updatedName.text, bio: updatedBio.text, phone: updatedPhone.text);

                                },
                                child:const Text('Update Cover'))),
                          if(cubit.profileImage != null && cubit.coverImage != null)
                            Expanded(child: ElevatedButton(
                                onPressed: (){
                                  cubit.uploadCoverImage(name: updatedName.text, bio: updatedBio.text, phone: updatedPhone.text);
                                  cubit.uploadProfileImage(name: updatedName.text, bio: updatedBio.text, phone: updatedPhone.text);

                                },
                                child:const Text('Update'))),
                        ],
                      ),
                    ),
                    /////////Name and bio///////////
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: updatedName,
                            decoration: InputDecoration(
                              label: const Text(
                                  'update name'),
                              hintText: userdata!.name,
                              border:
                              const OutlineInputBorder(),
                            ),
                          ),
                        ), //update name filed
                        Padding(
                          padding:
                          const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: updatedBio,
                            decoration: InputDecoration(
                              label: const Text(
                                  'update bio'),
                              hintText: userdata!.bio,
                              border:
                              const OutlineInputBorder(),
                            ),
                          ),
                        ), //update bio filed
                        Padding(
                          padding:
                          const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: updatedPhone,
                            decoration: InputDecoration(
                              label: const Text(
                                  'update phone'),
                              hintText: userdata!.phone,
                              border:
                              const OutlineInputBorder(),
                            ),
                          ),
                        ), //update phone filed
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
