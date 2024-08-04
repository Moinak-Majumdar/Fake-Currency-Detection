import 'dart:io';

import 'package:flutter_app/screens/pred_click.dart';
import 'package:flutter_app/screens/pred_uploaded.dart';
import 'package:flutter_app/widgets/intro.dart';
import 'package:flutter_app/widgets/neumorphism.dart';
import 'package:flutter_app/widgets/model_selection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker ip = ImagePicker();

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(context) {
    void routerPush(File? img, String routeName) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => routeName == 'upload'
              ? PredUploaded(pickedImage: img)
              : PredClick(pickedImage: img),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Fake Currency Detection")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Introduction(),
            const ModelSelection(),
            const Spacer(),
            NeuListTile(
              onTap: () async {
                final img = await _pickPicture(ImageSource.camera);
                routerPush(img, 'camera');
              },
              title: const Text(
                "Use Camera",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "Clear background helps better detection.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              trailing: const Icon(Icons.camera_alt),
              leading: const _LeadingIcon(),
            ),
            NeuListTile(
              onTap: () async {
                final img = await _pickPicture(ImageSource.gallery);
                routerPush(img, 'upload');
              },
              title: const Text(
                "Upload",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "Upload image from your gallery.",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              trailing: const Icon(Icons.image),
              leading: const _LeadingIcon(),
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Use caution:",
                  style: GoogleFonts.montserrat().copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: const [
                    TextSpan(
                      text: " Machine learning results may not be perfect.",
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> _pickPicture(ImageSource source) async {
    XFile? pickedImg = await ip.pickImage(source: source, maxHeight: 600);

    if (pickedImg == null) return null;

    return File(pickedImg.path);
  }
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon();

  @override
  Widget build(context) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xfff8acff),
            Color(0xff696eff),
          ],
        ),
      ),
      child: const Text(
        "₹",
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}
