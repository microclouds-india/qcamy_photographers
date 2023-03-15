import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewNetworkImage extends StatelessWidget {
  final String imageLink;

  const ViewNetworkImage({Key? key, required this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      imageProvider: NetworkImage(imageLink),
    );
  }
}

class ViewLocalImage extends StatelessWidget {
  final File image;

  const ViewLocalImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(imageProvider: FileImage(image));
  }
}
