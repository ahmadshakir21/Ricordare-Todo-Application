import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_application/src/model/task_model.dart';
import 'package:todo_application/src/style/app_style_color.dart';

class UpdateNote extends StatefulWidget {
  final TaskModel taskModel;
  UpdateNote({required this.taskModel});
  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  TextEditingController? titleController;
  TextEditingController? todoController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.taskModel.title);
    todoController = TextEditingController(text: widget.taskModel.description);
    super.initState();
  }

  @override
  void dispose() {
    titleController!.dispose();
    todoController!.dispose();
    super.dispose();
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

  updateTaskAndSendItToFirebase() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('myTasks')
        .doc(widget.taskModel.taskID)
        .update(TaskModel(
                taskID: widget.taskModel.taskID,
                title: titleController!.text,
                description: todoController!.text,
                time: widget.taskModel.time)
            .toMap())
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Successfully, You updated your task'),
              backgroundColor: thirdColorLight,
            )))
        .then((value) => Navigator.of(context).pop());
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
              height: height * 0.05,
            ),
            textFieldFunction(
                width: width,
                maxLine: 1,
                maxLength: 30,
                hintText: 'Task Name',
                controller: titleController!),
            SizedBox(
              height: height * 0.04,
            ),
            textFieldFunction(
                width: width,
                maxLine: 7,
                hintText: 'Task Description',
                controller: todoController!),
          ]),
        ),
        floatingActionButton: SizedBox(
          width: width * 0.8,
          height: height * 0.05,
          child: FloatingActionButton(
            onPressed: () {
              updateTaskAndSendItToFirebase();
            },
            backgroundColor: orangeColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              'UPDATE',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
