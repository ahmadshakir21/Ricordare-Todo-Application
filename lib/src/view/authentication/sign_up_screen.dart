import 'package:flutter/material.dart';
import 'package:todo_application/src/style/app_style_color.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: thirdColor,
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
                    color: thirdColorLight, shape: BoxShape.circle),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(20, -65),
            child: Container(
              height: height * 0.06,
              width: height * 0.06,
              decoration:
                  BoxDecoration(color: thirdColorLight, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
