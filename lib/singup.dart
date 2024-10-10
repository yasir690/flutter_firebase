import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetutorial/home.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
    TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  singup(String email,String password)async{
   if(email=="" && password==""){
     showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.teal,
          title: Text('Please provide email and password'),
        ),
      );
   }
   else{
    UserCredential ? userCredential;
    try{
         userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).
         then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())));
 
    }
    on FirebaseAuthException catch(ex){
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
        title: Text('Singup'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(2))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true ,
              decoration: InputDecoration(
                  hintText: 'Enter Your Password',
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(2))),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                // onPressed: singup(emailController.text.toString(),passwordController.text.toString()),
                                onPressed: () => singup(emailController.text.trim(), passwordController.text.trim()),

                style: ElevatedButton.styleFrom(
                  
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  // elevation: 10, // Elevation level
                ),
                child: Text(
                  'Signup',
                  style: TextStyle(fontSize: 20,color: Colors.black),
                )),
                
          ],
        ),
      ),
    );
  }
}