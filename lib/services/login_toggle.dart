import 'package:flutter/material.dart';
import 'package:project_cipherx/pages/login_page.dart';
import 'package:project_cipherx/pages/register_page.dart';

class SignInOrSignUp extends StatefulWidget {
  const SignInOrSignUp({super.key});

  @override
  State<SignInOrSignUp> createState() => _SignInOrSignUpState();
}

class _SignInOrSignUpState extends State<SignInOrSignUp> {
  bool isSignIn = true;

  void toggleScreen() {
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSignIn) {
      return LoginPage(onTap: toggleScreen);
    } else {
      return SignUpPage(onTap: toggleScreen);
    }
  }
}
