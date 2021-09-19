import 'dart:io';

import 'package:chat/screens/components/user_image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:chat/screens/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  AuthForm({ Key? key, required this.onSubmit }) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthFormData _formData = AuthFormData();


  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;

    if(_formData.image == null && _formData.isSignup) {
      _showError('Image not picked');
      return;
    }

    widget.onSubmit(_formData);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      )
    );
  }

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Card(
        margin: EdgeInsets.all(4.w),
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if(_formData.isSignup)
                  Column(
                    children: [
                      UserImagePicker(
                        onImagePick: _handleImagePick,
                      ),
                      SizedBox(height: 2.w),
                      TextFormField(
                        initialValue: _formData.name,
                        onChanged: (name) => _formData.name = name,
                        key: const ValueKey('name_key'),
                        decoration: const InputDecoration(
                          labelText: 'Name'
                        ),
                        validator: (String? name) {
                          final validator = NameValidator(name);
                          if(validator.isValid()) {
                            return null;
                          }
                          return validator.warningMessage;
                        },
                      ),
                    ],
                  ),
                TextFormField(
                  initialValue: _formData.email,
                  onChanged: (email) => _formData.email = email,
                  key: const ValueKey('email_key'),
                  decoration: const InputDecoration(
                    labelText: 'E-mail'
                  ),
                  validator: (String? email) {
                    final validator = EmailValidator(email);
                    if(validator.isValid()) {
                      return null;
                    }
                    return validator.warningMessage;
                  },
                ),
                TextFormField(
                  initialValue: _formData.password,
                  onChanged: (password) => _formData.password = password,
                  key: const ValueKey('password_key'),
                  decoration: const InputDecoration(
                    labelText: 'Password'
                  ),
                  validator: (String? password) {
                    final validator = PasswordValidator(password);
                    if(validator.isValid()) {
                      return null;
                    }
                    return validator.warningMessage;
                  },
                ),
                SizedBox(height: 4.h),
                ElevatedButton(
                  onPressed: _submit, 
                  child: Text(
                    _formData.isLogin 
                      ? 'Log in'
                      : 'Sign up'
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _formData.toggleAuthMode();
                    });
                  }, 
                  child: Text(
                    _formData.isLogin
                      ? 'Create new account'
                      : 'Already have an account?'
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}