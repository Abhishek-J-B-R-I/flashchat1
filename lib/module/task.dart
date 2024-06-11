class Task {
  final String tasktitle;
  final String Description;
  final String Deadline;
  final String Expectedtaskduration;
  bool ischecked;
  Task(
      {this.ischecked = false,
      required this.tasktitle,
      required this.Description,
      required this.Deadline,
      required this.Expectedtaskduration});

  void checkedfunction() {
    ischecked = !ischecked;
  }
}
