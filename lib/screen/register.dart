import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/screen/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class registration extends StatefulWidget {
  static String rg = 'register';

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner=false;
  late String email;
  late String pass;

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
                            image: AssetImage("images/logo.png"), height: 180)),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pass = value;
                },
                decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              ),
              SizedBox(
                height: 20,
              ),
              Hero(
                tag: 'r',
                child: FilledButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner=true;
                    });
                    try {
                      final newuser = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
                      if(newuser!=null){
                        Navigator.pushNamed(context, chat_screen.chatnow);
                      }
                    } catch(e){
                      print(e);
                    }
                  setState(() {
                    showSpinner=false;
                  });
                    // print(email);
                    //print(pass);
                  },
                  child: Text("Register"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.blueAccent)),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
/*

rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {

    // This rule allows anyone with your Firestore database reference to view, edit,
    // and delete all data in your Firestore database. It is useful for getting
    // started, but it is configured to expire after 30 days because it
    // leaves your app open to attackers. At that time, all client
    // requests to your Firestore database will be denied.
    //
    // Make sure to write security rules for your app before that time, or else
    // all client requests to your Firestore database will be denied until you Update
    // your rules
    match /{document=**} {
      allow read, write: if request.time < timestamp.date(2024, 3, 8);
    }
  }
}
 */