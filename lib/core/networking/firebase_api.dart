import 'package:cloud_firestore/cloud_firestore.dart';

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
    //get all tasks from firebase when the user id is equel to user id in firebase
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var taskCollection = firestore.collection('tasks').withConverter<Task>(
        fromFirestore: ((snapshot, options) => Task.fromJson(snapshot.data()!)),
        toFirestore: (task, options) => task.toJson()).where('user_id' , isEqualTo: 'user_id');
    var querySnapshot = await taskCollection.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
