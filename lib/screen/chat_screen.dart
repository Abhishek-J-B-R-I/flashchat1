import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
/*

if you want to make you chat in order way then visit thie website
https://stackoverflow.com/questions/57584317/messages-on-flutter-chat-app-not-in-proper-order


*/
final _firestorecloud = FirebaseFirestore.instance;
late User loguser;



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
        title: Row(
          children: [
            Image(image: AssetImage("images/logo.png"),height: 30,),Text("Chat Now"),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                //getdatamessageusingsnapchat();
                //getdatamessage();
                _auth.signOut();
            Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StreamBuilder(
                stream: _firestorecloud.collection('messages').orderBy('time',descending: false).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: Text("data not found")/*CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            )*/);
                  }


                  if (snapshot.hasData) {
                    final messages = snapshot.data?.docs.reversed;
                    List<mbubble> mw = [];
                    for (var message in messages!) {
                      final mt = message.data()['text'];
                      final ms = message.data()['sender'];
                      final messageTime=message.data()['time'];
                      final currentUser = loguser.email;



                      final messagebubbler = mbubble(
                        ms: ms,
                        mt: mt,
                        time: messageTime,
                        isMe: currentUser==ms,
                      );
                      mw.add(messagebubbler);
                    }

                    return Expanded(
                      child: ListView(
                        reverse: true,
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        children: mw,
                      ),
                    );
                  } else {
                    throw Exception('failed to retrieve messages');
                  }
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 310,
                    child: TextField(controller: messageTextController,style: TextStyle(color: Colors.white),
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
                              color: Color(0x433600),//0x433600
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

                        _firestorecloud.collection('messages').add({
                          'text': mes,
                          'sender': loguser.email,
                          'time':FieldValue.serverTimestamp()
                        });
                        messageTextController.clear();

                      },
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.lightBlueAccent,
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
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
/*

this code work fine except whenever i send message then i see red screen so that's why i comment this
class messages_stream extends StatelessWidget {
  const messages_stream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firestorecloud.collection('messages').orderBy('time',descending: false).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
                child: Text("data not found")/*CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            )*/);
          }
          if (snapshot.hasData) {
            final messages = snapshot.data?.docs.reversed;
            List<mbubble> mw = [];
            for (var message in messages!) {
              final mt = message.data()['text'];
              final ms = message.data()['sender'];
              final messageTime=message.data()['time'] as Timestamp;
              final currentUser = loguser.email;



              final messagebubbler = mbubble(
                ms: ms,
                mt: mt,
                time: messageTime,
                isMe: currentUser==ms,
              );
              mw.add(messagebubbler);
            }

            return Expanded(
              child: ListView(
                reverse: true,
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
*/


class mbubble extends StatelessWidget {
  mbubble({required this.ms, required this.mt, required this.isMe, required this.time});
  final String? mt;
  final String? ms;
  final bool isMe;
  final Timestamp? time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 5.0,
            color: isMe?Colors.lightBlueAccent:Color(0x6B03A9F4),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
                children: [
                  Text(
                    '$ms',
                    style: isMe?TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold):TextStyle(
                        color: Colors.lightBlueAccent, fontWeight: FontWeight.bold,),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$mt ',
                    style: TextStyle(fontSize: 15),
                  ),if(time != null)
                    Text(
                      '${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(time!.seconds * 1000))}',
                      style: TextStyle(fontSize: 10),
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
