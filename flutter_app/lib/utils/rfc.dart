import 'dart:io';

import 'package:flutter_app/getx/schema/output.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

double getMax(List<double> list) {
  double max = list.reduce((curr, next) => curr > next ? curr : next);
  return max;
}

Future<PredictionOutput> useRFC(File selectedImg) async {
  final interpreterOptions = InterpreterOptions();

  if (Platform.isAndroid) interpreterOptions.addDelegate(XNNPackDelegate());
  if (Platform.isIOS) interpreterOptions.addDelegate(GpuDelegateV2());

  final interpreter = await Interpreter.fromAsset(
    'assets/model/rfc_svc.tflite',
    options: interpreterOptions,
  );

  final imgData = selectedImg.readAsBytesSync();
  final image = img.decodeImage(imgData);

  final imageInput = img.copyResize(image!, height: 200, width: 400);

  final imageMatrix = List.generate(
    imageInput.height,
    (y) => List.generate(
      imageInput.width,
      (x) {
        final pixel = imageInput.getPixel(x, y);
        return [pixel.r, pixel.g, pixel.b];
      },
    ),
  );

  final input = [imageMatrix]; // shape (1, 200, 400, 3)

  final output = List.filled(4, 0).reshape([1, 4]); // shape (1, 4)

  interpreter.run(input, output);

  final max = getMax(output[0]);
  final posOfMax = output[0].indexOf(max);

  final confidence = (max * 100) - 2.12;

  final side = posOfMax == 0 || posOfMax == 2 ? 'Front' : 'Back';
  final pred = posOfMax < 2 ? 'counterfeit.' : 'genuine.';

  return PredictionOutput(
    prediction: pred,
    side: side,
    confidence: confidence,
  );
}
