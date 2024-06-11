import 'package:flutter/material.dart';
import 'package:untitled1/Screens/todotile.dart';
import 'package:untitled1/module/task.dart';

class todolist extends StatefulWidget {
  final List<Task> tasks;

  todolist({required this.tasks});

  @override
  State<todolist> createState() => _todolistState();
}

class _todolistState extends State<todolist> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return todotile(
          title1: widget.tasks[index].tasktitle,
          ischecked1: widget.tasks[index].ischecked,
          callbackfuncheckbox: (bool? newvalue) {
            setState(() {
              widget.tasks[index].checkedfunction();
            });
          },
          descr: widget.tasks[index].Description,
          line: widget.tasks[index].Deadline,
          Expectedtask: widget.tasks[index].Expectedtaskduration,

        );
      },
      itemCount: widget.tasks.length,
    );
  }
}
