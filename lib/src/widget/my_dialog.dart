import 'package:flutter/material.dart';
import 'package:todo_application/src/style/app_style_color.dart';

class MyDialog extends StatelessWidget {
  VoidCallback onPressed;

  MyDialog({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Dialog(
        elevation: 5,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
            height: height * 0.27,
            width: width * 0.9,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Alert",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: thirdColor),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Are you Sure want to delete this task?",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w600, color: thirdColor),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: width * 0.3,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: thirdColor),
                          child: Text(
                            "Cancel",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.3,
                        child: ElevatedButton(
                            onPressed: onPressed,
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                backgroundColor: redColor),
                            child: Text(
                              "Delete",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ])));
  }
}
