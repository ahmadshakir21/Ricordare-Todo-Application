import 'package:flutter/material.dart';
import 'package:todo_application/src/style/app_style_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
    );
  }
}
