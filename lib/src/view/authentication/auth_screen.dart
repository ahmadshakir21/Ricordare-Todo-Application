import 'package:flutter/material.dart';
import 'package:todo_application/src/view/authentication/sign_in_screen.dart';
import 'package:todo_application/src/view/authentication/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignIn = true;
  void toggle() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSignIn
        ? SignInScreen(onClickToSignUp: toggle)
        : SignUpScreen(
            onClickToSignIn: toggle,
          );
  }
}
