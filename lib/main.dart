import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_application/firebase_options.dart';
import 'package:todo_application/src/style/app_style_color.dart';
import 'package:todo_application/src/view/authentication/sign_in_screen.dart';
import 'package:todo_application/src/view/authentication/sign_up_screen.dart';
import 'package:todo_application/src/view/authentication/to_sign_in_screen.dart';

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
      theme: ThemeData(
          fontFamily: GoogleFonts.alatsi().fontFamily,
          textTheme: TextTheme(
              headline1: const TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 2),
              headline2: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 2),
              headline5: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 1,
                color: mainColor,
              ),
              headline6: TextStyle(
                  fontSize: 14, letterSpacing: 1, color: thirdColor))),
      home: ToSignInScreen(),
    );
  }
}
