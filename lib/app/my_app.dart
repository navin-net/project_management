import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:test_hello/auth/model/login_response.dart';
import 'package:test_hello/auth/screen/login_screen.dart';
import 'package:test_hello/constants/constants.dart';
import 'package:test_hello/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      final LocalStorage storage =  LocalStorage(Constants.user_local_key);
    return MaterialApp(
      title: 'HomeScreen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
     home: FutureBuilder(
        future: storage.ready,
        builder: (BuildContext context, snapshot){
          if(snapshot.data==true){
            final userData = storage.getItem(Constants.user_name_key);
            if(userData !=null){
              return HomeScreen();
            }
            return LoginScreen();
          }else{
            return LoginScreen();
          }
        }),
      );
  }
}