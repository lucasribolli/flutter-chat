import 'package:flutter/material.dart';

class SnackBarUtils {
  SnackBarUtils._();

  static showSnackBarError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }
}