import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/src/model/task_model.dart';
import 'package:todo_application/src/model/user_todo_model.dart';
import 'package:todo_application/src/style/app_style_color.dart';
import 'package:todo_application/src/view/add_note.dart';
import 'package:todo_application/src/view/authentication/to_sign_in_screen.dart';
import 'package:todo_application/src/view/update_note.dart';
import 'package:todo_application/src/widget/my_dialog.dart';
import 'package:todo_application/src/widget/my_drawer_header.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem('Profile', Icons.account_circle_sharp, () {}),
          menuItem('Logout', Icons.logout, () {
            showDialog(
              context: context,
              builder: (context) => MyDialog(
                  content: 'Are you sure want to Logout?',
                  onPressed: () {
                    _firebaseAuth
                        .signOut()
                        .then((value) => Navigator.of(context).pop());
                  }),
            );
          })
        ],
      ),
    );
  }

  Widget menuItem(String title, IconData iconData, VoidCallback onPressed) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(children: [
            Expanded(
                child: Icon(
              iconData,
              size: 23,
              color: thirdColor,
            )),
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: thirdColor),
                )),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      key: _key,
      backgroundColor: mainColor,
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: thirdColor,
            width: double.infinity,
            height: height * 0.25,
            padding: const EdgeInsets.only(top: 20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: height * 0.13,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: mainColor),
              ),
              // Text(userTodoModel.name!),
              // Text(userTodoModel.email!),
            ]),
          ),
          myDrawerList()
        ],
      )),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.01,
                ),
                IconButton(
                  onPressed: () {
                    _key.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu_rounded),
                  iconSize: 28,
                  color: thirdColor,
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(user!.uid)
                        .collection('myTasks')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            "Error...",
                          ),
                        );
                      } else if (snapshot.data == null) {
                        return const Center(
                          child: Text(
                            "Data is null",
                          ),
                        );
                      }

                      final myDocs = snapshot.data!.docs;

                      return Container(
                        height: height * 0.8,
                        child: ListView.builder(
                          itemCount: myDocs.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => UpdateNote(
                                          taskModel: TaskModel(
                                              taskID: myDocs[index]['taskID'],
                                              title: myDocs[index]['title'],
                                              description: myDocs[index]
                                                  ['description'],
                                              time: myDocs[index]['time'])),
                                    ));
                                  },
                                  child: Container(
                                    width: width * 1,
                                    decoration: BoxDecoration(
                                        color: thirdColorLight,
                                        borderRadius: BorderRadius.circular(7)),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              myDocs[index]['title'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: mainColorLight,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        MyDialog(
                                                      content:
                                                          'Are you sure want to delete this task?',
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('tasks')
                                                            .doc(user!.uid)
                                                            .collection(
                                                                'myTasks')
                                                            .doc(myDocs[index]
                                                                ['taskID'])
                                                            .delete()
                                                            .then((value) =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop())
                                                            .then((value) =>
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content:
                                                                      const Text(
                                                                          'You deleted your task'),
                                                                  backgroundColor:
                                                                      thirdColorLight,
                                                                )));
                                                      },
                                                    ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: redColor,
                                                )),
                                          ],
                                        ),
                                        Text(
                                          myDocs[index]['time'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(
                                                  color: mainColorLight
                                                      .withOpacity(0.75),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: height * 0.045,
                                        ),
                                        Text(
                                          myDocs[index]['description'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6!
                                              .copyWith(color: mainColorLight),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNote(),
          ));
        },
        backgroundColor: orangeColor,
        child: const Icon(Icons.add),
      ),
    ));
  }
}
