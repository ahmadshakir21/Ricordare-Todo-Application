import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? title;
  String? description;
  String? time;

  TaskModel({this.title, this.description, this.time});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'time': time,
    };
  }

  factory TaskModel.fromMap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return TaskModel(
      title: snapshot['title'],
      description: snapshot['description'],
      time: snapshot['time'],
    );
  }
}
