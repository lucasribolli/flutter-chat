import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({Key? key}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 10.w,
          backgroundColor: Colors.grey,
        ),
        TextButton.icon(
          onPressed: () {},
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
