import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/view/login_page.dart';
import 'package:to_do_app/view_model/home_page_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeviewModel>(
      create: (BuildContext context) => HomeviewModel(),
      child: MaterialApp(
        title: 'TO DO',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Loginpage(),
      ),
    );
  }
}
