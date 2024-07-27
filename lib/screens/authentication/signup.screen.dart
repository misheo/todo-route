import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  Future addUserDetails(
    String firstName,
    String lastName,
    String email,
    int age,
  ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'age': age,
    });
  }

  Future signUp() async {
    if (_passwordController.text == _passwordConfirmController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
        addUserDetails(
            _firstNameController.text.trim(),
            _lastNameController.text.trim(),
            _emailController.text.trim(),
            int.parse(_ageController.text.trim()));
        //add user details
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          if (e.code == 'weak-password') {
            Navigator.of(context).push(DialogRoute(
                context: context,
                builder: (context) => const AlertDialog(
                        title: Row(
                      children: [
                        Icon(Icons.error),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Weak Password'),
                      ],
                    ))));
          } else if (e.code == 'email-already-in-use') {
            Navigator.of(context).push(DialogRoute(
                context: context,
                builder: (context) => const AlertDialog(
                        title: Row(
                      children: [
                        Icon(Icons.error),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Email already in use'),
                      ],
                    ))));
          } else {
            Navigator.of(context).push(DialogRoute(
                context: context,
                builder: (context) => const AlertDialog(
                        title: Row(children: [
                      Icon(Icons.error),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Something went wrong'),
                    ]))));
          }
        }
      }
    } else {
      _passwordController.clear();
      _passwordConfirmController.clear();
      if (mounted) {
        Navigator.of(context).push(DialogRoute(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Row(
                    children: [
                      Icon(Icons.error),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Password do not match'),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Ok'))
                  ],
                )));
      }
    }

    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    // _genderController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final List<Widget> children = [
      Image.asset(
        'asset/logo.png',
        height: 200,
      ),
      const SizedBox(
        height: 20,
      ),
      // Text('WELCOME',
      //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
      //         fontWeight: FontWeight.bold,
      //         color: Theme.of(context).colorScheme.primary,
      //         fontSize: 32)),
      const SizedBox(
        height: 20,
      ),
      Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              'SIGN_UP',
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.primary),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: _passwordConfirmController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'CONFIRM_PASSWORD',
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
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'FIRSTNAME',
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
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'LASTNAME',
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
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'AGE',
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
                  signUp();
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                ),
                child: Text('SIGN_UP'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Text(
                'LOGIN',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.center,
              ),
              onTap: widget.onPressed,
            )
          ],
        ),
      )
    ];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: height >= width
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
