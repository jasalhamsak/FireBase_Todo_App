import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TaskModel{


  String?id;
  String?title;
  String?body;
  int?status;
  DateTime?taskAt;

  TaskModel({this.id,this.title,this.body,this.status,this.taskAt});


    factory TaskModel.fromJson(DocumentSnapshot json){

Timestamp?timestamp =json['taskAt'];
   return TaskModel(
     id: json['id'],
     title: json['title'],
     body: json['body'],
     status: json['status'],
     taskAt: timestamp?.toDate(),
   );
  }

  Map<String,dynamic>toMap(){
      return {
        'id':id,
        'title':title,
        'body': body,
        'status':status,
        'taskAt':taskAt
      };
  }



}