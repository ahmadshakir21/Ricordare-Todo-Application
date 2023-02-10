import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/src/style/app_style_color.dart';
import 'package:todo_application/src/view/home_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key, required this.onClickToSignUp}) : super(key: key);

  VoidCallback onClickToSignUp;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget textFieldWidget(TextEditingController controller,
      String? Function(String?)? validator, String hintText, bool obscureText) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: TextStyle(
        color: thirdColor,
      ),
      cursorColor: secondColor,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: thirdColor.withOpacity(0.75)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: thirdColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: secondColor),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen(),
              )));
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
        )..show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: 'Authentication Error',
          desc: 'Wrong password provided for that user.',
          btnOkOnPress: () {},
          btnOkColor: Colors.red,
        )..show();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
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
                        color: mainColorLight, shape: BoxShape.circle),
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(20, -65),
                child: Container(
                  height: height * 0.06,
                  width: height * 0.06,
                  decoration: BoxDecoration(
                      color: mainColorLight, shape: BoxShape.circle),
                ),
              ),
              SizedBox(
                height: height * 0.001,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome Back",
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(color: secondColor),
                    )),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
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
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: SizedBox(
                  width: width * 1,
                  height: height * 0.05,
                  child: ElevatedButton(
                      onPressed: signIn,
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(), primary: orangeColor),
                      child: Text(
                        "Sign In",
                        style: Theme.of(context).textTheme.headline5,
                      )),
                ),
              ),
              RichText(
                text: TextSpan(
                    text: 'Do not have an Account?',
                    style: Theme.of(context).textTheme.headline6,
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Sign up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickToSignUp,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: secondColor)),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
