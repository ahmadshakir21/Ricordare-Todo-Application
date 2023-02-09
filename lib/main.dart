import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/firebase_options.dart';
import 'package:todo_application/src/provider/auth_provider.dart';
import 'package:todo_application/src/style/app_style_color.dart';

import 'package:todo_application/src/view/authentication/to_sign_in_screen.dart';
import 'package:todo_application/src/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: GoogleFonts.alatsi().fontFamily,
            textTheme: TextTheme(
                headline1: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
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
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else if (!snapshot.hasData) {
              return const ToSignInScreen();
            }
            return HomeScreen();
          },
        ),
      ),
    );
  }
}
