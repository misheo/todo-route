import 'package:flutter/material.dart';

import 'login.dart';
import 'signup.screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool login = true;
  void _onPressed() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return login
        ? LoginScreen(
            onPressed: _onPressed,
          )
        : SignUpScreen(
            onPressed: _onPressed,
          );
  }
}
