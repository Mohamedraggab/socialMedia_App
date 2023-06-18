import 'package:flutter/material.dart';
import 'package:socialmedia/Login_cubit/cubit.dart';
import 'package:socialmedia/Login_cubit/observer.dart';
import 'package:socialmedia/login&&register/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socialmedia/screens/layout.dart';
import 'package:socialmedia/shared/global/dio_helper.dart';
import 'package:socialmedia/shared/local/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.initDio();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget? startScreen;
    if(CacheHelper.getData(key: 'uId') != null)
      {
        startScreen = const Layout() ;
      }
    else{
      startScreen = const LoginScreen();
    }


    return BlocProvider(
      create: (context) => AppCubit()..getUserData()..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //fontFamily: AutofillHints.jobTitle,
          scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        ),
        home: startScreen,
      ),
    );
  }
}
