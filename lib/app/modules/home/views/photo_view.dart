// ignore_for_file: file_names, void_checks, always_use_package_imports

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoViewPage extends StatefulWidget {
  final String? image;
  const PhotoViewPage({
    this.image,
    super.key,
  });

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: Image.network(
                  widget.image!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              right: 20.0,
              top: 20.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(CupertinoIcons.xmark_circle, color: Colors.white, size: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
