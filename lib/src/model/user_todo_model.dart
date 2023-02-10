import 'package:cloud_firestore/cloud_firestore.dart';

class UserTodoModel {
  final String? id;
  final String? email;
  final String taskName;
  final String taskDescription;

  UserTodoModel({
    this.id,
    this.email,
    required this.taskName,
    required this.taskDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'taskName': taskName,
      'taskDescription': taskDescription,
    };
  }

  factory UserTodoModel.fromMap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserTodoModel(
      id: snapshot['id'],
      email: snapshot['email'],
      taskName: snapshot['taskName'],
      taskDescription: snapshot['taskDescription'],
    );
  }
}
