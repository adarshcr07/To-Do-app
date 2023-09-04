import 'package:flutter/material.dart';

class HomeviewModel extends ChangeNotifier {
  List Mainlist = [];

  TextEditingController dateinput = TextEditingController();
  //text editing controller for text field
  TextEditingController taskdetails = TextEditingController();

  void addtask() {
    String task = taskdetails.text;
    String date = dateinput.text;

    Mainlist.add({'key1': task, 'key2': date});
    notifyListeners();
  }

  void resetfieald() {
    taskdetails.clear();
    dateinput.clear();
  }
}
