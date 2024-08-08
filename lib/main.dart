import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/todo_app.dart';

import 'core/helper/cash.dart';
import 'provider/settings_provider.dart';
import 'provider/tasks_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SharedPreferences
  await Cash().init();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Start the app with the SettingsProvider
  runApp(MultiProvider(
    // create: (BuildContext context) => SettingsProvider(),
    providers: [
      ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ChangeNotifierProvider(create: (context) => TaskProvider()),
    ],
    child: const TodoApp(),
  ));
}
