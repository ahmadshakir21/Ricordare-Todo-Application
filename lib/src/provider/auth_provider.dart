import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future? signUp(emailController, passwordController, formKey,
      BuildContext context, bool confirmPassword) async {
    try {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;
      if (confirmPassword) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      }
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Authentication Error',
          desc: 'The password provided is too weak.',
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Authentication Error',
          desc: 'The account already exists for that email.',
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future? signIn(emailController, passwordController, formKey,
      BuildContext context) async {
    try {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      // .then((value) => Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => HomeScreen(),
      //     )));
      notifyListeners();
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Authentication Error',
          desc: 'No user found for that email.',
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Authentication Error',
          desc: 'Wrong password provided for that user.',
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        ).show();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future logout() async {
    await _firebaseAuth.signOut();
    notifyListeners();
  }
}
