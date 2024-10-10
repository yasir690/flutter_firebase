import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetutorial/forgetpassword.dart';
import 'package:firebasetutorial/home.dart';
import 'package:firebasetutorial/singup.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
    if (email == "" && password == "") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.teal,
          title: Text('Please provide email and password'),
        ),
      );
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen())));
      } on FirebaseAuthException catch (ex) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(ex.code),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('login'),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Enter Your Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    // onPressed: login(emailController.text.toString(),passwordController.text.toString()),
                    onPressed: () => login(emailController.text.trim(),
                        passwordController.text.trim()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                      // elevation: 10, // Elevation level
                    ),
                    child: Text(
                      'login',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
                Row(
                  children: [
                    Text(
                      'Already have an account??',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text(
                          'SignUp',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'ForgetPassword??',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPassword()));
                        },
                        child: Text(
                          'Forget Password',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
