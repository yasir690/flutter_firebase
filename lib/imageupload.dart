import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  String? _uploadStatus;

 Future<void> _pickImage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }
}

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;

    try {
      // Create a unique file name
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');

      // Upload the file
      await storageRef.putFile(_imageFile!);
      setState(() {
        _uploadStatus = "Upload successful!";
      });
    } catch (e) {
      setState(() {
        _uploadStatus = "Upload failed: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        _imageFile != null
            ? Image.file(_imageFile!)
            : Text("No image selected."),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _pickImage,
          child: Text("Pick Image"),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _uploadImage,
          child: Text("Upload Image"),
        ),
        SizedBox(height: 20),
        if (_uploadStatus != null) Text(_uploadStatus!),
      ],
    );
  }
}
