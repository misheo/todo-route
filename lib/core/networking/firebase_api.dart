import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';

class FirebaseApi {
  static CollectionReference getTaskCollection() {
    return FirebaseFirestore.instance.collection('task').withConverter<Task>(
        fromFirestore: ((snapshot, options) => Task.fromJson(snapshot.data()!)),
        toFirestore: (task, options) => task.toJson());
  }

  static Future<void> addTaskToFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var taskCollection = firestore.collection('tasks').withConverter<Task>(
        fromFirestore: ((snapshot, options) => Task.fromJson(snapshot.data()!)),
        toFirestore: (task, options) => task.toJson());
  }

  static Future<List<Task>> getTasksFromFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var taskCollection = firestore.collection('tasks').withConverter<Task>(
        fromFirestore: ((snapshot, options) => Task.fromJson(snapshot.data()!)),
        toFirestore: (task, options) => task.toJson());
    var tasks = await taskCollection.get();
    return tasks.docs.map((e) => e.data()).toList();
  }
}
