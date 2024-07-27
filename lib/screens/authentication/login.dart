import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/theme/app_colors.dart';
import '../../core/widgets/app_text_filed.dart';
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
              AppLocalizations.of(context)!.login,
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
              padding: EdgeInsets.symmetric(horizontal: 25.0.w),
              child: AppTextFormField(
                controller: _emailController,
                hintText: AppLocalizations.of(context)!.email,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(text)) {
                    return 'Please enter a valid email';
                  }
                  if (text.length < 6) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
             SizedBox(
              height: 10.h,
            ),
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0.w),
              child: AppTextFormField(
                controller: _passwordController,
                hintText: AppLocalizations.of(context)!.password,
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (text.length < 6) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              ),
            ),

            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0.w),
              child: ElevatedButton(
                onPressed: () {
                  _login();
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ) , 
                  
                  ),
                  backgroundColor:  AppColors.primary
                ),
                child: Text(AppLocalizations.of(context)!.login),
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ResetScreen()));
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
