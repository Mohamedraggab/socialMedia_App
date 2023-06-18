import 'package:flutter/material.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/login&&register/login.dart';
import 'package:socialmedia/modules/shared_modules.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userController = TextEditingController();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            if(state is CreateUserSuccessAppState)
              {
                Navigator.pop(context);
              }
          },
          builder: (context, state) => Scaffold(
            body: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Register now',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,
                                  fontSize: 22)),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 15),
                            child: Text('Register now to create new account',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey.shade600,
                                )),
                          ),
                          customTextFiled(
                            labelString: 'Username',
                            prefixIcon: Icons.person_2_outlined,
                            validateFunction: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Username';
                              }
                              return null;
                            },
                            isPassword: false,
                            keyboardType: TextInputType.name,
                            controller: userController,
                          ), ///////username
                          const SizedBox(
                            height: 8,
                          ),
                          customTextFiled(
                            labelString: 'Email',
                            prefixIcon: Icons.email_outlined,
                            validateFunction: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Email';
                              }
                              return null;
                            },
                            isPassword: false,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          ), ///////email
                          const SizedBox(
                            height: 8,
                          ),
                          customTextFiled(
                            labelString: 'password',
                            prefixIcon: Icons.lock_outline,
                            validateFunction: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Password';
                              }
                              return null;
                            },
                            isPassword: true,
                            keyboardType: TextInputType.visiblePassword,
                            controller: passController,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          customTextFiled(
                            labelString: 'Phone number',
                            prefixIcon: Icons.phone,
                            validateFunction: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Your Phone Number';
                              }
                              return null;
                            },
                            isPassword: false,
                            keyboardType: TextInputType.phone,
                            controller: phoneController,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ConditionalBuilder(
                            condition: state is! RegisterAppState ,
                            builder: (context) => customButton(
                                labelString: 'Register',
                                formKey: formKey,
                                onPress: () {
                                  if(formKey.currentState!.validate())
                                  {
                                    AppCubit.get(context).userRegister(
                                        username: userController.text,
                                        email: emailController.text,
                                        password: passController.text,
                                        phone: phoneController.text);
                                  }
                                }),////login Button
                            fallback: (context) =>const Center(child: CircularProgressIndicator()),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('already have account ',
                                  style: TextStyle(color: Colors.grey)),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ));
                                },
                                style: const ButtonStyle(
                                    overlayColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                child: const Text('Login now',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
