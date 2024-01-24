import 'package:flutter/material.dart';
import 'package:untitled1/screen/chat_screen.dart';

class loginpage extends StatefulWidget {

  static String l='loginpage';

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage("images/logo.png"),
                    height: 150,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                    50,
                  )),
                  hintText: "Enter your email"),
            ),
            SizedBox(height: 10,),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              //keyboardType: TextInputType.,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  hintText: "Enter your password"),
            ),
            SizedBox(height: 30,),
            Hero(
              tag: 'lg',
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, chat_screen.chatnow);
                },
                child: Text(
                  "Log In",
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightBlueAccent)),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.home),backgroundColor: Colors.blueAccent,onPressed: (){Navigator.pop(context);},),
    );
  }
}
