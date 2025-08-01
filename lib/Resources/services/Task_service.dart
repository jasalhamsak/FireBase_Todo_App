import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasedemo/Resources/Models/Task_model.dart';

class TaskService {
  final CollectionReference _taskCollection =
      FirebaseFirestore.instance.collection('tasks');

  Future<TaskModel?> createTask(TaskModel task) async {
    try {
      final _taskMap = task.toMap();
      await _taskCollection.doc(task.id).set(_taskMap);

      return task;
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Stream<List<TaskModel>> getAllTask() {
    try {
      return _taskCollection.snapshots().map((QuerySnapshot snapshot) {
        return snapshot.docs.map((DocumentSnapshot doc) {
          return TaskModel.fromJson(doc);
        }).toList();
      });
    } on FirebaseException catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> updateTask(TaskModel task) async {
    try {
      final taskMap = task.toMap();
      await _taskCollection.doc(task.id).update(taskMap);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> deleteTask(String? id) async {
    try {
      await _taskCollection.doc(id).delete();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
