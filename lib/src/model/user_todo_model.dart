import 'package:cloud_firestore/cloud_firestore.dart';

class UserTodoModel {
  String? userId;
  String? name;
  String? image;
  String? email;

  UserTodoModel({
    this.userId,
    this.name,
    this.image,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'image': image,
      'email': email,
    };
  }

  factory UserTodoModel.fromMap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserTodoModel(
      userId: snapshot['userId'],
      name: snapshot['name'],
      image: snapshot['image'],
      email: snapshot['email'],
    );
  }
}
