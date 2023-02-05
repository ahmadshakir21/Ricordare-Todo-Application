import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/src/style/app_style_color.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key, required this.onClickToSignUp}) : super(key: key);

  VoidCallback onClickToSignUp;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget textFieldWidget(
      TextEditingController controller, String hintText, bool obscureText) {
    return TextField(
      controller: controller,
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: mainColor,
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
                    textFieldWidget(emailController, 'Email Address', false),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    textFieldWidget(passwordController, 'Password', true),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: SizedBox(
                width: width * 1,
                height: height * 0.05,
                child: ElevatedButton(
                    onPressed: () {},
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
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onClickToSignUp,
                  children: <TextSpan>[
                    TextSpan(
                        text: ' Sign up',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.w600, color: secondColor)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
