import 'package:flutter/material.dart';
import 'package:todo_application/src/style/app_style_color.dart';

class MyDrawerHeader extends StatelessWidget {
  String username;
  String email;

  MyDrawerHeader({required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: secondColor,
      width: double.infinity,
      height: height * 0.25,
      padding: const EdgeInsets.only(top: 20),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: height * 0.13,
          decoration: BoxDecoration(shape: BoxShape.circle, color: mainColor),
        ),
        Text(username),
        Text(email),
      ]),
    );
  }
}
