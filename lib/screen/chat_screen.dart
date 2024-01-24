import 'package:flutter/material.dart';

class chat_screen extends StatefulWidget {
  static String chatnow='chat_screen';
  //const chat_screen({super.key});

  @override
  State<chat_screen> createState() => _chat_screenState();
}

class _chat_screenState extends State<chat_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Now"),
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "Type your message here..."),
                  ),
                ),
                TextButton(onPressed: () {}, child: Text("Send"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
