import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetutorial/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

logout(){
  FirebaseAuth.instance.signOut();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed:(){ logout();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text(
          'home',
          style: TextStyle(color: Colors.teal, fontSize: 30),
        ),
      ),
    );
  }
}
