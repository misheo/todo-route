
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'restet.password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  void _login() async {
    try {
      print(_emailController.text.trim());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(e.code);
        if (mounted) {
          if (e.code == 'user-not-found') {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('User not found'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Ok'))
                      ],
                    ));
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('Wrong password or email'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Ok'))
                      ],
                    ));
            print('Wrong password provided for that user.');
          }
        }
      }
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final List<Widget> children = [
      Image.asset(
        'assets/images/logo.png',
        height: 200,
      ),
      
   
      Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'login',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.primary),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'EMAIL',
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                            // fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.primary),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'PASSWORD',
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                            // fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: ElevatedButton(
                onPressed: () {
                  _login();
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                ),
                child: Text('LOGIN'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Text(
                'FORGOT_PASSWORD',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  ResetScreen()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: widget.onPressed,
              child: Text(
                'SIGN_UP',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      )
    ];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: height >= width
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: children,
                ),
        ),
      ),
    );
  }
}
