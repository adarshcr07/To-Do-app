import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/view_model/home_page_view_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.user});

  final String user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To do',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 51, 113, 221),
        elevation: 20,
        shadowColor: Color.fromARGB(255, 14, 14, 14),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'add task',
        onPressed: () {
          // showAboutDialog(context: context);
          // build(context) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Consumer<HomeviewModel>(
                    builder: (context, pointer, child) {
                  return AlertDialog(
                    title: Text(
                      'Create The Task for ${user}',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 29, 66, 129),
                              fontWeight: FontWeight.bold)),
                    ),
                    content: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Form(
                            child: Column(
                          children: [
                            TextFormField(
                              controller: pointer.taskdetails,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 51, 113, 221),
                                        width: 2,
                                      )),
                                  labelText: 'Task Details',
                                  labelStyle: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                    color: Color.fromARGB(255, 29, 66, 129),
                                    fontWeight: FontWeight.w600,
                                  )),
                                  icon: Icon(
                                    Icons.article,
                                    color: Color.fromARGB(255, 29, 66, 129),
                                  )),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 51, 113, 221),
                                        width: 2,
                                      )),
                                  labelText: 'DATE',
                                  labelStyle: GoogleFonts.roboto(
                                    color: Color.fromARGB(255, 29, 66, 129),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  icon: Icon(Icons.calendar_today,
                                      color: Color.fromARGB(255, 29, 66, 129))),
                              controller: pointer.dateinput,
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2200));

                                // if the user picks a date the if block will executed
                                if (pickedDate != null) {
                                  print(pickedDate);
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy')
                                          .format(pickedDate);
                                  print(formattedDate);
                                  Provider.of<HomeviewModel>(context,
                                          listen: false)
                                      .dateinput
                                      .text = formattedDate;
                                } else {
                                  print('You are not entered any date');
                                }
                              },
                            ),
                          ],
                        )),
                      ),
                    ),
                    elevation: 15,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            pointer.resetfieald();
                          },
                          child: Text(
                            'Dont Save',
                            style: TextStyle(
                              color: Color.fromARGB(255, 29, 66, 129),
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            pointer.addtask();
                            Navigator.of(context).pop();
                            pointer.resetfieald();
                          },
                          child: Text(
                            'Add to Task',
                            style: TextStyle(
                              color: Color.fromARGB(255, 29, 66, 129),
                              fontWeight: FontWeight.w600,
                            ),
                          )),
                    ],
                  );
                });
              });
        },
        backgroundColor: const Color.fromARGB(255, 51, 113, 221),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<HomeviewModel>(builder: (context, pointer, child) {
        return ListView.builder(
            itemCount: pointer.Mainlist.length,
            itemBuilder: (BuildContext context, int index) {
              var item = pointer.Mainlist[index];
              return Dismissible(
                  key: ValueKey(item),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${pointer.Mainlist[index]['key1']} deleated")));
                    Provider.of<HomeviewModel>(context, listen: false)
                        .Mainlist
                        .removeAt(index);
                  },
                  background:
                      Container(color: const Color.fromARGB(255, 185, 32, 21)),
                  child: ListTile(
                    title: Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 7),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.indigo),
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      child: Center(
                        child: Text(
                          '${pointer.Mainlist[index]['key1']} on ${pointer.Mainlist[index]['key2']}',
                          style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 25,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                    ),
                  ));
            });
      }),
    );
  }
}
