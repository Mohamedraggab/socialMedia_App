import 'package:flutter/material.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/states.dart';
import 'package:socialmedia/login&&register/register.dart';
import 'package:socialmedia/modules/shared_modules.dart';
import 'package:socialmedia/screens/layout.dart';
import 'package:socialmedia/shared/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/shared/local/shared_preferences.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
        create: (context)=>  AppCubit(),
      child: BlocConsumer<AppCubit ,AppState>(
        listener:(context, state) {
          if(state is GetUserSuccessAppState)
          {
            uId = state.uId ;
            CacheHelper.putData(key: 'uId', value: uId);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const Layout(),));
          }
          },


        builder: (context, state) => Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25 ,left: 15),
                  child: Text('Welcome\nback' ,style: TextStyle(fontWeight: FontWeight.w700 ,color: Colors.grey.shade700 ,fontSize: 22)),
                ),
                customTextFiled(
                  labelString: 'Email',
                  prefixIcon: Icons.person,
                  validateFunction: (value){
                    if(value!.isEmpty)
                    {
                      return 'Enter Your Email';
                    }
                    return null ;
                  },
                  isPassword: false,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController ,
                ),
                const SizedBox(height: 8,),
                customTextFiled(
                  labelString: 'Password',
                  prefixIcon: Icons.lock_outline,
                  validateFunction: (value){
                    if(value!.isEmpty)
                    {
                      return 'Enter Your Password';
                    }
                    return null ;
                  },
                  isPassword: true,
                  keyboardType: TextInputType.text,
                  controller: passController ,
                ),
                const SizedBox(height: 8,),

                ConditionalBuilder(
                    condition: state is! LoginAppState ,
                    builder: (context) => customButton(
                        labelString: 'LOGIN',
                        formKey: formKey,
                        onPress:()
                        {
                          if(formKey.currentState!.validate())
                          {
                            AppCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passController.text,
                            );
                          }
                        }
                    ), ////login Button
                  fallback: (context) =>const Center(child: CircularProgressIndicator()),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Create a new account'),
                    TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),));
                      },
                      style: const ButtonStyle(
                          overlayColor: MaterialStatePropertyAll(Colors.white)
                      ),
                      child: const Text('Register now'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
