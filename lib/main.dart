import 'package:untitled1/screen/chat_screen.dart';
import 'package:untitled1/screen/loginpage.dart';
import 'package:untitled1/screen/register.dart';
import 'package:flutter/material.dart';
import 'screen/welcomescreen.dart';
void main(){
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
      theme: ThemeData.dark().copyWith(
          textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.black45)
          )
      ),
      initialRoute: Welcomescreen.r,
      routes: {
        loginpage.l:(context)=>loginpage(),
        registration.rg:(context)=>registration(),

        Welcomescreen.r:(context)=>Welcomescreen(),
        chat_screen.chatnow:(context)=>chat_screen(),
      },

    );
  }
}
