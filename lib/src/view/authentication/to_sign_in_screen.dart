import 'package:flutter/material.dart';
import 'package:todo_application/src/style/app_style_color.dart';
import 'package:todo_application/src/view/authentication/auth_screen.dart';
import 'package:todo_application/src/view/authentication/sign_in_screen.dart';

class ToSignInScreen extends StatelessWidget {
  const ToSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: secondColor,
      body: Column(
        children: [
          Transform.translate(
            offset: const Offset(50, -50),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: height * 0.25,
                width: height * 0.25,
                decoration: BoxDecoration(
                    color: secondColorLight, shape: BoxShape.circle),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(20, -65),
            child: Container(
              height: height * 0.06,
              width: height * 0.06,
              decoration: BoxDecoration(
                  color: secondColorLight, shape: BoxShape.circle),
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
                  "Lind",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: mainColor),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: height * 0.009,
                width: width * 0.13,
                color: orangeColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 75),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Be ready for a new experience",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: mainColor),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 75),
            child: SizedBox(
              width: width * 1,
              height: height * 0.05,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AuthScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(), primary: orangeColor),
                  child: Text(
                    "Go to Sign in Screen",
                    style: Theme.of(context).textTheme.headline5,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
