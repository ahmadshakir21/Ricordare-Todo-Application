import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_application/src/style/app_style_color.dart';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController todoController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    todoController.dispose();
    super.dispose();
  }

  Widget textFieldFunction(
      {required double width,
      required int maxLine,
      required String hintText,
      required TextEditingController controller}) {
    return Center(
        child: Container(
            width: width * 0.9,
            child: TextField(
              controller: controller,
              cursorColor: secondColor,
              maxLines: maxLine,
              style: TextStyle(
                color: thirdColor,
              ),
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: secondColor.withOpacity(0.85)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: secondColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: secondColor),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            )));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              )),
          SizedBox(
            height: height * 0.05,
          ),
          textFieldFunction(
              width: width,
              maxLine: 1,
              hintText: 'Title',
              controller: titleController),
          SizedBox(
            height: height * 0.04,
          ),
          textFieldFunction(
              width: width,
              maxLine: 7,
              hintText: 'Todo',
              controller: todoController),
        ]),
      ),
      floatingActionButton: SizedBox(
        width: width * 0.8,
        height: height * 0.05,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: orangeColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Text('ADD TODO'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
