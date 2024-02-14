import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/services/firebase_services.dart';
import 'package:to_do_app/view/home_page.dart';

import 'package:url_launcher/url_launcher_string.dart';

class Loginpage extends StatefulWidget {
  @override
  Loginpagestate createState() => Loginpagestate();
}

class Loginpagestate extends State<Loginpage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  bool isLoggedin = false;

  void initState() {
    super.initState();
    LoginStatus();
  }

  // ignore: non_constant_identifier_names
  LoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedin = prefs.getBool('isLoggedin') ?? false;

    if (isLoggedin) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedUsername = prefs.getString('username');
      String? storedPassword = prefs.getString('password');
      if (storedUsername != null && storedPassword != null) {
        namecontroller.text = storedUsername;
        passcontroller.text = storedPassword;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(
            user: namecontroller.text,
          ),
        ),
      );
    }
  }

  //handeling the login button
  userlogin() async {
    String user = namecontroller.text;
    String pass = passcontroller.text;

    if (user == 'user' && pass == 'password') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', user); // Store username
      await prefs.setString('password', pass); // Store password
    } else {
      Text('error login');
    }
  }

  final remoteconfig = FirebaseRemoteConfigService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 2.5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(60))),
          backgroundColor: Color.fromARGB(255, 54, 73, 95),
          shadowColor: Colors.black,
          elevation: 30,
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
                  color: Color.fromARGB(255, 54, 73, 95),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: TextButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          //  userlogin()?

                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return MyHomePage(user: namecontroller.text);
                          }));
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
            ),

            SizedBox(
              height: 2,
            ),
            //underlined text button which navigates to whatsap
            TextButton(
              onPressed: () async {
                //getting the remoteconfig data
                String whatnum = remoteconfig
                    .getString(FirebaseRemoteConfigKeys.whatsapNumber);
                print('anser $whatnum');

                String message =
                    remoteconfig.getString(FirebaseRemoteConfigKeys.message);

                print(" mess $message");
                String whatsurl =
                    'https://wa.me/$whatnum/?text=${Uri.parse(message)}';
                if (await canLaunchUrlString(whatsurl)) {
                  await launchUrlString(whatsurl);
                } else {
                  throw "Error occured sending an email";
                }
                debugPrint('clickedd');
              },
              child: const Text(
                'Need Any Help!',
                style: TextStyle(
                  color: Color.fromARGB(255, 54, 73, 95),
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
