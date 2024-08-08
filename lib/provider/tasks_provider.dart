import 'package:flutter/material.dart';

import '../core/models/task.dart';

class TaskProvider extends ChangeNotifier {

  List<Task> tasks = [];

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    tasks.remove(task);
    tasks.add(task);
    notifyListeners();
  }
  

}