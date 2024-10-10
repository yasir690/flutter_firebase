

import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetutorial/checkuser.dart';
import 'package:firebasetutorial/imageupload.dart';
import 'package:firebasetutorial/insertdata.dart';
import 'package:firebasetutorial/login.dart';
import 'package:firebasetutorial/user.dart';
import 'package:flutter/material.dart';

void main()async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InsertData(),
      debugShowCheckedModeBanner: false,
    );
  }
}