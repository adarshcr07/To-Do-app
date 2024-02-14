import 'package:flutter/material.dart';

class HomeviewModel extends ChangeNotifier {
  List Mainlist = [];
//text editing controller for text field
  TextEditingController dateinput = TextEditingController();
  
  TextEditingController taskdetails = TextEditingController();

  //colors for the homepage background
  final startColor = Color.fromARGB(255, 255, 255, 255);
  final endColor = Color.fromARGB(255, 56, 82, 112);

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
