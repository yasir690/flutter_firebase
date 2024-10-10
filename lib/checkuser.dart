import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetutorial/home.dart';
import 'package:firebasetutorial/login.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Show loading indicator while checking
      ),
    );
  }

  void checkUser() {
    final user = FirebaseAuth.instance.currentUser;

    // Use Future.delayed to ensure navigation occurs after the build phase
    Future.delayed(Duration.zero, () {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }
}
