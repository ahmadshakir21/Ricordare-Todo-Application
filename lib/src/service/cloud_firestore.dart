import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_application/src/model/user_todo_model.dart';

class CloudFirestore {
  static Future create(UserTodoModel userTodoModel) async {
    final userCollection = FirebaseFirestore.instance.collection('user_task');

    final uid = userCollection.doc().id;
    final docRef = userCollection.doc(uid);

    final newUserTodo = UserTodoModel(
      id: uid,
      email: userTodoModel.email,
      taskName: userTodoModel.taskName,
      taskDescription: userTodoModel.taskDescription,
    ).toMap();

    try {
      await docRef.set(newUserTodo);
    } catch (e) {
      print("some error occured $e");
    }
  }
}
