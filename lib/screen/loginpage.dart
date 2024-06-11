import 'package:flutter/material.dart';
import 'package:untitled1/Screens/taskscreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class loginpage extends StatefulWidget {

  static String l='loginpage';

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner=false;
  late String email;
  late String password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Image(
                        image: AssetImage("images/logo.png"),
                        height: 250,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              TextField(
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email=value;
                },
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
                obscureText: true,style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
                //keyboardType: TextInputType.,
                onChanged: (value) {
                  password=value;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)),
                    hintText: "Enter your password"),
              ),
              SizedBox(height: 30,),
              Hero(
                tag: 'lg',
                child: FilledButton(
                  onPressed: () async{
                    setState(() {
                      showSpinner=true;
                    });
                   try{
                     final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
                     if(user!=null){
                       Navigator.pushNamed(context, TaskScreen.ts);
                     }

                   }catch(e){
                     print(e);
                   }
                    setState(() {
                      showSpinner=false;
                    });
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
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.home),backgroundColor: Colors.blueAccent,onPressed: (){Navigator.pop(context);},),
    );
  }
}
