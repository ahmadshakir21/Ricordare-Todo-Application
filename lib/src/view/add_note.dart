import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import 'package:todo_application/src/model/task_model.dart';
import 'package:todo_application/src/model/user_todo_model.dart';
import 'package:todo_application/src/service/cloud_firestore.dart';
import 'package:todo_application/src/style/app_style_color.dart';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  addTaskToFirebase() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    var time = DateTime.now();

    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('myTasks')
        .doc(time.toString())
        .set(TaskModel(
                taskID: time.toString(),
                title: taskNameController.text,
                description: taskDescriptionController.text,
                time: DateFormat.yMMMd().format(time))
            .toMap())
        .then((value) => Navigator.of(context).pop());

    var snackBar = SnackBar(
      content: const Text('Successfully, You added your task'),
      backgroundColor: thirdColorLight,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget textFieldFunction(
      {required double width,
      required int maxLine,
      int? maxLength,
      required String hintText,
      required TextEditingController controller}) {
    return Center(
        child: Container(
            width: width * 0.9,
            child: TextField(
              controller: controller,
              cursorColor: thirdColor,
              maxLines: maxLine,
              maxLength: maxLength,
              style: TextStyle(
                color: thirdColor,
              ),
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: thirdColor.withOpacity(0.65)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: thirdColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: thirdColor),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            )));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: height * 0.01,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: thirdColor,
              ),
              iconSize: 28,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            textFieldFunction(
                width: width,
                maxLine: 1,
                maxLength: 30,
                hintText: 'Task Name',
                controller: taskNameController),
            SizedBox(
              height: height * 0.04,
            ),
            textFieldFunction(
                width: width,
                maxLine: 7,
                hintText: 'Task Description',
                controller: taskDescriptionController),
          ]),
        ),
        floatingActionButton: SizedBox(
          width: width * 0.8,
          height: height * 0.05,
          child: FloatingActionButton(
            onPressed: () {
              addTaskToFirebase();
            },
            backgroundColor: orangeColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              'ADD TODO',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
