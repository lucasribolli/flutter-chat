import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File image) onImagePick;
  const UserImagePicker({ 
    Key? key,
    required this.onImagePick
  }) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _image;

  FileImage? _getBackgroundImage() {
    return _image != null 
      ? FileImage(_image!) 
      : null;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if(pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
    widget.onImagePick(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: _getBackgroundImage(),
        ),
        SizedBox(height: 2.w),
        TextButton(
          onPressed: _pickImage, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 2.w),
              const Text('Add image'),
            ],
          ),
        ),
      ],
    );
  }
}