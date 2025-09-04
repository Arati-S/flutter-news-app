import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../../profile/bloc/profile_event.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import 'dart:io';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController textController = TextEditingController();
  File? _pickedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final postBloc = context.read<PostBloc>();
    final profileBloc = context.read<ProfileBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: "Post text"),
            ),
            const SizedBox(height: 10),
            _pickedImage != null
                ? Image.file(_pickedImage!, height: 150)
                : const SizedBox(),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text("Pick Image (Optional)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Dispatch CreatePost event with optional image
                postBloc.add(CreatePost(
                  text: textController.text,
                  imageUrl: _pickedImage?.path, // optional
                ));

                // Notify ProfileBloc to reload points
                profileBloc.add(LoadPoints());

                Navigator.pop(context);
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
