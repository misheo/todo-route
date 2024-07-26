import 'package:flutter/material.dart';
import 'package:todo/todo_app.dart';

import 'core/helper/cash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Cash().init();
  runApp(const TodoApp());
}
