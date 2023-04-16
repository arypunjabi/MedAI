import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_compare/image_compare.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Page')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(picture.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          Text(imageCompare().toString())
        ]),
      ),
    );
  }

// ...

  Future<double> imageCompare() async {
    var a = Image.file(File(picture.path), fit: BoxFit.cover, width: 250);
    var b =
        File("/Users/aryanpunjabi/Desktop/cancer_detection/lib/melanoma.jpeg");

    var imageResult = await compareImages(
        src1: a, src2: b, algorithm: EuclideanColorDistance());

    print('Difference: ${imageResult * 100}%');
    return imageResult;
  }
}
