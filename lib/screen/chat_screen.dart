import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class chat_screen extends StatefulWidget {
  static String chatnow = 'chat_screen';
  //const chat_screen({super.key});

  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  final _auth = FirebaseAuth.instance;
  final _firestorecloud=FirebaseFirestore.instance;
  late String mes;
  //FirebaseUser loguser;
  late User loguser;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    currenuser();
}

  void currenuser() async {
    try {

      final user= await _auth.currentUser;
      if(user!=null){
        loguser=user;
        //print(loguser.email);
      }

    } catch (e) {
      print(e);
    }
  }
/*void getdatamessage()async{
  final message=await _firestorecloud.collection('messages').get();
  for (var ms in message.docs){
    print(ms.data());

  }
}*/

  void getdatamessageusingsnapchat()async{
    await for(var i in  _firestorecloud.collection('messages').snapshots()){
      for(var ms in i.docs){
        print(ms.data());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Now"),
        actions: [
          IconButton(onPressed: (){
              getdatamessageusingsnapchat();
            //getdatamessage();
            /*_auth.signOut();
            Navigator.pop(context);*/
          }, icon: Icon(Icons.close))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 310,
                  child: TextField(
                    onChanged: (value) {
                      mes=value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "Type your message here..."),
                  ),
                ),
                TextButton(onPressed: () {
                  _firestorecloud.collection('messages').add({
                    'text':mes,
                    'sender':loguser.email,

                  });
                }, child: Text("Send"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
