import 'package:flutter/material.dart';
import 'package:todo/core/networking/firebase_api.dart';

import '../core/models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  var selectDate = DateTime.now();
  void changeSelectDate(DateTime date) {
    selectDate = date;
    getAllTasks();
    notifyListeners();
  }

  Future<void> getAllTasks() async {
    tasks = await FirebaseApi.getTasksFromFirebase();

    tasks = tasks.where((task) {
      if (task.date.year == selectDate.year &&
          task.date.month == selectDate.month &&
          task.date.day == selectDate.day) {
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }

  bool addTask(Task task) {
    FirebaseApi.addTaskToFirebase(task).then((_) {
      tasks.add(task);
      notifyListeners();
      return true;
    });
    return false;
  }

  void removeTask(Task task) {
    FirebaseApi.deleteTask(task).then((_) {
      tasks.remove(task);
    });
    notifyListeners();
  }

  void updateTask(Task task) {
    FirebaseApi.updateTask(task).then((_) {
      
    tasks.remove(task);
    tasks.add(task);
    }) ; 

    notifyListeners();
  }
}
