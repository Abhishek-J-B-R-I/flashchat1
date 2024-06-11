import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/Screens/todolist.dart';
import 'package:untitled1/Screens/addtask.dart';
import 'package:untitled1/module/task.dart';

class TaskScreen extends StatefulWidget {
  static String ts='TaskScreen';

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [
    Task(tasktitle: 'flutter work',Expectedtaskduration: "1 day",Description: "task management",Deadline: "24 hours",),
    Task(tasktitle: 'flutter work',Expectedtaskduration: "1 day",Description: "task management",Deadline: "24 hours",),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: addtask(
                      addtaskcallback: (newtasktitle,Description,Deadline,ExpectedTaskDuration) {
                        print(newtasktitle);
                        setState(() {
                          tasks.add(Task(tasktitle: newtasktitle,Deadline: Deadline,Description: Description,Expectedtaskduration: ExpectedTaskDuration));
                        });
                        Navigator.pop(context);

                      },
                    )),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.lightBlueAccent,
        );
      }),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.list,
                      size: 30,
                      color: Colors.lightBlueAccent,
                    ),
                    backgroundColor: Colors.white,
                    radius: 30,
                  ),
                  Text(
                    "TODO",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 50),
                  ),
                  Text(
                    "12 Tasks",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: todolist(tasks: tasks),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
