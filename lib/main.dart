import 'package:untitled1/Screens/taskscreen.dart';

import 'package:untitled1/screen/loginpage.dart';
import 'package:untitled1/screen/register.dart';
import 'package:flutter/material.dart';
import 'screen/welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
/*

if you want to make you chat in order way then visit thie website
https://stackoverflow.com/questions/57584317/messages-on-flutter-chat-app-not-in-proper-order


*/

Future main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( );
  runApp(
      chatapp()
  );
}

class chatapp extends StatelessWidget {
  const chatapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute: Welcomescreen.r,
      routes: {
        loginpage.l:(context)=>loginpage(),
        registration.rg:(context)=>registration(),

        Welcomescreen.r:(context)=>Welcomescreen(),
        TaskScreen.ts:(context)=>TaskScreen(),
      },

    );
  }
}
