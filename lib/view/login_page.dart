import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/view/home_page.dart';

class Loginpage extends StatefulWidget {
  @override
  Loginpagestate createState() => Loginpagestate();
}

class Loginpagestate extends State<Loginpage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  bool isLoggedin = false;
  String user = '';
  String pass = '';

  void initState() {
    super.initState();
    Login();
  }

  void Login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.getString('username') ?? '';
    pass = prefs.getString('password') ?? '';

    if (user.isNotEmpty && pass.isNotEmpty) {
      isLoggedin = true;
    }
  }

  Future<void> userlogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', namecontroller.text);
    prefs.setString('password', passcontroller.text);

    setState(() {
      isLoggedin = true;
      user = namecontroller.text;
      pass = passcontroller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 2.5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(60))),
          backgroundColor: const Color.fromARGB(255, 51, 113, 221),
          shadowColor: Colors.black,
          elevation: 20,
          title: Center(
            child: Text(
              'Welcome',
              style: GoogleFonts.cookie(
                  textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 70,
              )),
            ),
          )),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: const Color.fromARGB(255, 51, 113, 221),
                        ),
                        borderRadius: BorderRadius.circular(14)),
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == Null) {
                      return '* username required';
                    } else if (value.length == 8) {
                      return '*there must be 8 characters';
                    }
                    return null;
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: TextFormField(
                obscureText: true,
                controller: passcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: const Color.fromARGB(255, 51, 113, 221),
                      ),
                      borderRadius: BorderRadius.circular(14)),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value!.isEmpty || value == Null) {
                    return '* password required';
                  } else if (value.length == 8) {
                    return '8 characters required';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Container(
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width / 3.5,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 51, 113, 221),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: TextButton(
                      onPressed: () async {
                        userlogin();
                        if (formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage(
                                title: 'test',
                              ),
                            ),
                          );
                        } else {
                          print(Text('LOGIN ERROR'));
                          return;
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
