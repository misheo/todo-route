import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/todo_app.dart';

import 'core/helper/cash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cash().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TodoApp());
}
