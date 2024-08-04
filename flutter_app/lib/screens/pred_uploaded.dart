import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/getx/controller/model_selection.dart';
import 'package:flutter_app/getx/schema/output.dart';
import 'package:flutter_app/utils/cnn.dart';
import 'package:flutter_app/utils/rfc.dart';
import 'package:flutter_app/utils/svc.dart';
import 'package:flutter_app/widgets/neumorphism.dart';
import 'package:flutter_app/widgets/submit_button.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PredUploaded extends StatefulWidget {
  const PredUploaded({super.key, this.pickedImage});
  final File? pickedImage;

  @override
  State<PredUploaded> createState() => _PredUploadedState();
}

class _PredUploadedState extends State<PredUploaded> {
  File? _selectedImg;
  final ImagePicker ip = ImagePicker();
  bool _isLoading = false;
  final msc = Get.put(ModelSelectionController());

  @override
  void initState() {
    setState(() {
      _selectedImg = widget.pickedImage;
    });
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Upload"),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _selectedImg = null;
                  _isLoading = false;
                });
              },
              icon: const Icon(Icons.restart_alt)),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
        child: Column(
          children: [
            NeuBox(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 32),
              borderRadius: 12,
              child: Container(
                alignment: Alignment.center,
                height: 220,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade200,
                      Colors.grey.shade300,
                      Colors.grey.shade300
                    ],
                  ),
                ),
                child: _selectedImg == null
                    ? Center(
                        child: TextButton.icon(
                          onPressed: _pickPicture,
                          icon: const Icon(Icons.image, color: Colors.black87),
                          label: const Text(
                            'Upload Image',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          Image.file(
                            _selectedImg!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 300,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black.withAlpha(170),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton.icon(
                                    onPressed: _isLoading ? null : _pickPicture,
                                    icon: const Icon(Icons.undo),
                                    label: const Text(
                                      'Reupload',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            NeuBox(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              child: SubmitButton(
                onTap: _selectedImg == null ? () {} : handelVerify,
                loading: _isLoading,
                title: "Verify",
                onLoadText: "Verifying ...",
                showDisable: _selectedImg == null,
                leadingIcon: Icons.search,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickPicture() async {
    XFile? pickedImg =
        await ip.pickImage(source: ImageSource.gallery, maxHeight: 600);

    if (pickedImg == null) return;
    setState(() {
      _selectedImg = File(pickedImg.path);
    });
  }

  void handelVerify() async {
    if (_selectedImg == null) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    late PredictionOutput res;
    final selectedModel = msc.selected.value;

    switch (selectedModel) {
      case 'cnn':
        res = await useCNN(_selectedImg!);
        break;
      case 'svc':
        res = await useSVC(_selectedImg!);
        break;
      case 'rfc':
        res = await useRFC(_selectedImg!);
        break;
    }

    showSmack(res);

    setState(() {
      _isLoading = false;
    });
  }

  void showSmack(PredictionOutput res) {
    ScaffoldMessenger.of(context).clearSnackBars();
    if (res.confidence < 50.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Unable to make prediction.",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: RichText(
            text: TextSpan(
              text: "${res.side} side detected: The currency note is ",
              style: const TextStyle(fontSize: 18, color: Colors.black87),
              children: [
                TextSpan(
                  text: res.prediction,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(text: "\n\nPrediction confidence: "),
                TextSpan(
                  text: "${res.confidence.toStringAsFixed(2)}%",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
