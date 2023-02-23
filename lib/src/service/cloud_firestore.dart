// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:todo_application/src/model/user_todo_model.dart';

// class CloudFirestore {
//   // static Future create(UserTodoModel userTodoModel) async {
//   //   final userCollection = FirebaseFirestore.instance.collection('user');

//   //   final uid = userCollection.doc().id;
//   //   final docRef = userCollection.doc(uid);

//   //   final newUserTodo = UserTodoModel(
//   //     userId: uid,
//   //     name: userTodoModel.name,
//   //     image: userTodoModel.image,
//   //     email: userTodoModel.email,
//   //   ).toMap();

//   //   try {
//   //     await docRef.set(newUserTodo);
//   //   } catch (e) {
//   //     print("some error occured $e");
//   //   }
//   // }

//   // static Stream<List<UserTodoModel>> read() {
//   //   final userCollection = FirebaseFirestore.instance.collection('user');

//   //   return userCollection.snapshots().map((querySnapshot) =>
//   //       querySnapshot.docs.map((e) => UserTodoModel.fromMap(e)).toList());
//   // }

//   static Future update(UserTodoModel userTodoModel) async {
//     final userCollection = FirebaseFirestore.instance.collection('user');

//     final docRef = userCollection.doc(userTodoModel.userId);

//     final newUserTodoUpdate = UserTodoModel(
//       userId: userTodoModel.userId,
//     ).toMap();

//     try {
//       await docRef.update(newUserTodoUpdate);
//     } catch (e) {
//       print("some error occured $e");
//     }
//   }

//   static Future delete(UserTodoModel userTodoModel) async {
//     final userCollection = FirebaseFirestore.instance.collection('user');

//     final docRef = userCollection.doc(userTodoModel.userId).delete();
//   }
// }
