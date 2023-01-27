import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiImagePickedScreen extends StatefulWidget {
  final List<XFile>? imageFiles;

  const MultiImagePickedScreen({Key? key, required this.imageFiles})
      : super(key: key);

  @override
  State<MultiImagePickedScreen> createState() => _MultiImagePickedScreenState();
}

class _MultiImagePickedScreenState extends State<MultiImagePickedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Picked Images"),
      ),
      body: Container(
        color: Colors.amberAccent,
        child: ListView.builder(
            itemCount: widget.imageFiles?.length,
            itemBuilder: (context, index) {
              return Image.file(
                File(widget.imageFiles![index].path),
                height: 200,
                width: 200,
              );
            }),
      ),
    );
  }
}
