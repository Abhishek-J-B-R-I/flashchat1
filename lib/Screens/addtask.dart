import 'package:flutter/material.dart';

class addtask extends StatelessWidget {
  final Function addtaskcallback;
  addtask({required this.addtaskcallback});

  @override
  Widget build(BuildContext context) {
    String? newtexttitle;
    String? Description;
    String? Deadline;
    String? ExpectedTaskDuration;
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add Task",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 40),
            ),
            Text("title:"),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                print(value);
                  newtexttitle=value;
              },
            ),
            Text("Description"),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                print(value);
                Description=value;
              },
            ),

            Text("Deadline"),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                print(value);
                Deadline=value;
              },
            ),
            Text("Expected Task Duration: "),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                print(value);
                ExpectedTaskDuration=value;
              },
            ),



            FilledButton(
              onPressed: () {
                print(newtexttitle);
                addtaskcallback(newtexttitle,Description,Deadline,ExpectedTaskDuration);
              },
              child: Text("Add"),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.lightBlueAccent)),
            )
          ],
        ),//hello
      ),
      height: 300,
      decoration: BoxDecoration(
          color: Color(0xECECECEC),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    );
  }
}
