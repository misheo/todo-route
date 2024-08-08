import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task.dart';

class FirebaseApi {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance.collection('tasks').withConverter<Task>(
        fromFirestore: ((snapshot, options) => Task.fromJson(snapshot.data()!)),
        toFirestore: (task, options) => task.toJson());
  }

  static Future<void> addTaskToFirebase(Task task) async {
    var taskCollection = getTaskCollection();
    DocumentReference<Task> tasksRef = taskCollection.doc();
    task.id = tasksRef.id;
    await tasksRef.set(task);
  }

  static Future<List<Task>> getTasksFromFirebase() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var taskCollection = firestore
          .collection('tasks')
          .withConverter<Task>(
              fromFirestore: ((snapshot, options) =>
                  Task.fromJson(snapshot.data()!)),
              toFirestore: (task, options) => task.toJson())
          .where("user_id", isEqualTo: user.uid);
      var querySnapshot = await taskCollection.get();
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    }
    return [];
  }

  static Future<void> deleteTask(Task task) async {
    getTaskCollection().doc(task.id).delete();
  }
    static Future<void> updateTask(Task task) async {
    var taskCollection = getTaskCollection();

    // Update the document with the new data
    await taskCollection.doc(task.id).update(task.toJson());
  }
}
