import 'package:flutter_app/getx/controller/model_selection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ModelSelection extends StatelessWidget {
  const ModelSelection({super.key});

  @override
  Widget build(context) {
    return Obx(
      () {
        final msc = Get.put(ModelSelectionController());
        final selected = msc.selected.value;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Model Selection : ",
              style: GoogleFonts.robotoMono().copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            ListTile(
              title: const Text(
                'Convolutional Neural Network',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              leading: Radio<String>(
                value: 'cnn',
                groupValue: selected,
                onChanged: (val) => msc.selected.value = val!,
              ),
              onTap: () => msc.selected.value = 'cnn',
            ),
            ListTile(
              title: const Text(
                'Support Vector Classifier',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              leading: Radio<String>(
                value: 'svc',
                groupValue: selected,
                onChanged: (val) => msc.selected.value = val!,
              ),
              onTap: () => msc.selected.value = 'svc',
            ),
            ListTile(
              title: const Text(
                'Random Forest Classifier',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              leading: Radio<String>(
                value: 'rfc',
                groupValue: selected,
                onChanged: (val) => msc.selected.value = val!,
              ),
              onTap: () => msc.selected.value = 'rfc',
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
