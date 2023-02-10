import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/main.dart';
import 'package:todo_application/src/style/app_style_color.dart';
import 'package:todo_application/src/view/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.onClickToSignIn}) : super(key: key);

  VoidCallback onClickToSignIn;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget textFieldWidget(TextEditingController controller,
      String? Function(String?)? validator, String hintText, bool obscureText) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: TextStyle(
        color: mainColor,
      ),
      cursorColor: secondColorLight,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: mainColor.withOpacity(0.75)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: mainColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: secondColorLight),
        ),
      ),
    );
  }

  bool confirmPasswordFunction() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future signUp() async {
    try {
      final isvalid = formKey.currentState!.validate();
      if (!isvalid) return;
      if (confirmPasswordFunction()) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .then((value) => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                )));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Authentication Error',
          desc: 'The password provided is too weak.',
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        )..show();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Authentication Error',
          desc: 'The account already exists for that email.',
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        )..show();
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: thirdColor,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Transform.translate(
                offset: const Offset(50, -50),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: height * 0.25,
                    width: height * 0.25,
                    decoration: BoxDecoration(
                        color: thirdColorLight, shape: BoxShape.circle),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(20, -65),
                child: Container(
                  height: height * 0.06,
                  width: height * 0.06,
                  decoration: BoxDecoration(
                      color: thirdColorLight, shape: BoxShape.circle),
                ),
              ),
              SizedBox(
                height: height * 0.001,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: mainColor),
                    )),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    children: [
                      textFieldWidget(emailController, (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                .hasMatch(value)) {
                          return 'Enter correct email';
                        } else {
                          return null;
                        }
                      }, 'Email Address', false),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      textFieldWidget(passwordController, (value) {
                        if (value != null && value.length < 6) {
                          return 'Enter min. 6 characters';
                        } else {
                          return null;
                        }
                      }, 'Password', true),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      textFieldWidget(confirmPasswordController, (value) {
                        if (value != null && value.length < 6) {
                          return 'Enter min. 6 characters';
                        } else if (value != passwordController.text.trim()) {
                          return "Password must be same as above";
                        } else {
                          return null;
                        }
                      }, 'Confirm Password', true),
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox(
                  width: width * 1,
                  height: height * 0.05,
                  child: ElevatedButton(
                      onPressed: signUp,
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(), primary: orangeColor),
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.headline5,
                      )),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: 'Already have an Account?',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: mainColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Sign in',
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickToSignIn,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: orangeColor)),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
