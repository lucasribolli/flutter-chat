import 'dart:io';

import 'package:flutter/material.dart';

class UserImageHelper {
  String url;
  double maxRadius;

  UserImageHelper({
    required this.url,
    required this.maxRadius,
  });

  CircleAvatar image() {
    ImageProvider provider;

    if (_isNetworkImage()) {
      provider = NetworkImage(url);
    } else if (_isDefaultImage()) {
      provider = AssetImage(url);
    } else {
      provider = FileImage(File(url));
    }

    return CircleAvatar(
      maxRadius: maxRadius,
      backgroundImage: provider,
    );
  }

  bool _isNetworkImage() {
    Uri uri = Uri.parse(url);
    return uri.scheme.contains('http');
  }

  bool _isDefaultImage() {
    return url.startsWith('assets');
  }
}
