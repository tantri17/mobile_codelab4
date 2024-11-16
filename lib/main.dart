import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Picker',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const ImagePickerScreen(),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _pickedFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickVideo(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickVideo(source: source);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Picker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pickedFile != null
                ? (_pickedFile!.path.endsWith('.mp4')
                    ? Container(
                        height: 200,
                        child: Center(
                          child: Text(
                            'Video Selected',
                            style:
                                TextStyle(color: Colors.purple, fontSize: 18),
                          ),
                        ),
                      )
                    : Image.file(
                        _pickedFile!,
                        height: 200,
                        fit: BoxFit.cover,
                      ))
                : Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(child: Text('No file selected')),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.camera),
              child: const Text('Pick Image from Camera'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text('Pick Image from Gallery'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _pickVideo(ImageSource.camera),
              child: const Text('Pick Video from Camera'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _pickVideo(ImageSource.gallery),
              child: const Text('Pick Video from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
