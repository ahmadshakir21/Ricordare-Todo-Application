import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/main.dart';
import 'package:todo_application/src/style/app_style_color.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, required this.onClickToSignIn}) : super(key: key);

  VoidCallback onClickToSignIn;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

  Widget textFieldWidget(
      TextEditingController controller, String hintText, bool obscureText) {
    return TextField(
      controller: controller,
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: thirdColor,
      body: SingleChildScrollView(
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Column(
                  children: [
                    textFieldWidget(emailController, 'Email Address', false),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    textFieldWidget(passwordController, 'Password', true),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    textFieldWidget(
                        confirmPasswordController, 'Confirm Password', true),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: SizedBox(
                width: width * 1,
                height: height * 0.05,
                child: ElevatedButton(
                    onPressed: () {},
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
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickToSignIn,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Sign in',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w600, color: orangeColor)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
