import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/firebase_options.dart';
import 'package:todo_application/src/view/authentication/sign_in_screen.dart';
import 'package:todo_application/src/view/authentication/sign_up_screen.dart';
import 'package:todo_application/src/view/authentication/to_sign_in_screen.dart';
import 'package:todo_application/src/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToSignInScreen(),
    );
  }
}
