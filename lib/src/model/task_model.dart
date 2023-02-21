import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String taskID;
  String? title;
  String? description;
  String? time;

  TaskModel({required this.taskID, this.title, this.description, this.time});

  Map<String, dynamic> toMap() {
    return {
      'taskID': taskID,
      'title': title,
      'description': description,
      'time': time,
    };
  }

  factory TaskModel.fromMap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TaskModel(
      taskID: snapshot['taskID'],
      title: snapshot['title'],
      description: snapshot['description'],
      time: snapshot['time'],
    );
  }
}
