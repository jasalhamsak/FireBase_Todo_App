import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? emial;
  String? password;
  String? name;
  DateTime? createdAt;
  int? status;
  String? uid;

  UserModel(
      {this.emial,
      this.password,
      this.name,
      this.createdAt,
      this.status,
      this.uid});

  factory UserModel.fromJson(DocumentSnapshot data) {
    return UserModel(
        emial: data['email'],
        uid: data['uid'],
        name: data['name'],
        status: data['status'],
        createdAt: data['createdAt']);
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": emial,
      "password": password,
      "status": status,
      "createdAt": createdAt
    };
  }
}
