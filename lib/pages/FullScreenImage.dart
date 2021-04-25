import 'dart:io';

import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final File imagePath;
  const FullScreenImage({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Image.file(
          imagePath,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
