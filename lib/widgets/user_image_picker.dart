import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedFile) onImagePick;

  const UserImagePicker(this.onImagePick);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  late File _pickedImageFile;
  late bool _imagePicked; 

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera, 
      imageQuality: 50, 
      maxWidth: 150,
    );

    if(pickedImage != null) {
      setState(() {
        _pickedImageFile = File(pickedImage.path);
      });
    }

    widget.onImagePick(_pickedImageFile);
  }

  @override
  void initState() {
    _imagePicked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: _imagePicked ? FileImage(_pickedImageFile) : null,
          radius: 10.w,
          backgroundColor: Colors.grey,
        ),
        TextButton.icon(
          onPressed: () async {
            await _pickImage();
            setState(() {
              _imagePicked = true;
            }); 
          },
          icon: Icon(
            Icons.image,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            'Adicionar imagem',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
