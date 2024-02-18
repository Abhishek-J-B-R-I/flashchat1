import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestorecloud = FirebaseFirestore.instance;

class chat_screen extends StatefulWidget {
  static String chatnow = 'chat_screen';
  //const chat_screen({super.key});

  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  final messageTextController= TextEditingController();
  final _auth = FirebaseAuth.instance;

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
      final user = await _auth.currentUser;
      if (user != null) {
        loguser = user;
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

  void getdatamessageusingsnapchat() async {
    await for (var i in _firestorecloud.collection('messages').snapshots()) {
      for (var ms in i.docs) {
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
          IconButton(
              onPressed: () {
                getdatamessageusingsnapchat();
                //getdatamessage();
                /*_auth.signOut();
            Navigator.pop(context);*/
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            messages_stream(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 310,
                    child: TextField(controller: messageTextController,
                      onChanged: (value) {
                        mes = value;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0x342196F3),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0x433600))),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x433600),
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          hintText: "Type your message here..."),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        messageTextController.clear();
                        _firestorecloud.collection('messages').add({
                          'text': mes,
                          'sender': loguser.email,
                        });
                      },
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.lightBlueAccent,
                          child: Icon(
                            Icons.send,
                            color: Colors.black,
                          )))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class messages_stream extends StatelessWidget {
  const messages_stream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestorecloud.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ));
          }
          if (snapshot.hasData) {
            final messages = snapshot.data?.docs;
            List<mbubble> mw = [];
            for (var message in messages!) {
              final mt = message.data()['text'];
              final ms = message.data()['sender'];
              final messagebubbler = mbubble(
                ms: ms,
                mt: mt,
              );
              mw.add(messagebubbler);
            }

            return Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                children: mw,
              ),
            );
          } else {
            throw Exception('failed to retrieve messages');
          }
        });
  }
}

class mbubble extends StatelessWidget {
  mbubble({required this.ms, required this.mt});
  final String? mt;
  final String? ms;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 5.0,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$ms',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$mt ',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
