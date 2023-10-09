import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/services/firebase_services.dart';
import 'package:to_do_app/view/login_page.dart';
import 'package:to_do_app/view_model/home_page_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseRemoteConfigService()
      .initialize(); // without this code the remoteconfig not work properly.
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
