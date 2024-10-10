import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void insertData(BuildContext context, String name, String email) {
    if (name.isEmpty || email.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.teal,
          title: Text('Please provide both name and email'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    } else {
      // Insert data into Firestore
      FirebaseFirestore.instance.collection('post').doc(name).set({
        "Name": name,
        "Email": email,
      }).then((value) {
        // log("Data inserted");
        // Clear input fields after successful insertion
        nameController.clear();
        emailController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data inserted successfully!')),
        );
      }).catchError((error) {
        // log("Failed to insert data: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to insert data: $error')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Data'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Enter your name'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Enter your email'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => insertData(
                context,
                nameController.text.trim(),
                emailController.text.trim(),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
              ),
              child: Text(
                'Submit', // Changed from 'login' to 'Submit'
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
