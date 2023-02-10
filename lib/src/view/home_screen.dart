import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/src/style/app_style_color.dart';
import 'package:todo_application/src/view/authentication/to_sign_in_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  _firebaseAuth.signOut().then(
                      (value) => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ToSignInScreen(),
                          )));
                },
                child: const Text("Log out"))
          ],
        ),
      ),
    );
  }
}
