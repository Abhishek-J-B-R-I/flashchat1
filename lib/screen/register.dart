import 'package:flutter/material.dart';

class registration extends StatefulWidget {
  static String rg = 'register';

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {

  late String email;
  late String pass;

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
                        image: AssetImage("images/logo.png"), height: 180)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextField(keyboardType: TextInputType.emailAddress,textAlign: TextAlign.center,onChanged: (value) {
              email=value;
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
            TextField(obscureText: true,textAlign: TextAlign.center,onChanged: (value) {
              pass=value;
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
                onPressed: () {
                  print(email);
                  print(pass);
                },
                child: Text("Register"),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blueAccent)),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.home),backgroundColor: Colors.blueAccent,onPressed: (){
        Navigator.pop(context);
      },),
    );
  }
}
