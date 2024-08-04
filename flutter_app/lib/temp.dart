// void handelVerify() async {
//   if (_selectedImg == null) {
//     return;
//   }
//   setState(() {
//     _isLoading = true;
//   });

//   final interpreterOptions = InterpreterOptions();

//   if (Platform.isAndroid) interpreterOptions.addDelegate(XNNPackDelegate());
//   if (Platform.isIOS) interpreterOptions.addDelegate(GpuDelegateV2());

//   final interpreter = await Interpreter.fromAsset(
//     'assets/model.tflite',
//     options: interpreterOptions,
//   );
//   final labels = ['10', '100', '20', '200', '2000', '50', '500'];

//   final imgData = _selectedImg!.readAsBytesSync();
//   final image = img.decodeImage(imgData);

//   final imageInput = img.copyResize(image!, height: 200, width: 400);

//   final imageMatrix = List.generate(
//     imageInput.height,
//     (y) => List.generate(
//       imageInput.width,
//       (x) {
//         final pixel = imageInput.getPixel(x, y);
//         return [pixel.r, pixel.g, pixel.b];
//       },
//     ),
//   );

//   final input = [imageMatrix]; // shape (1, 100, 200, 3)

//   final output = List.filled(7, 0).reshape([1, 7]); // shape (1, 7)

//   interpreter.run(input, output);

//   final max = getMax(output[0]);
//   final posOfMax = output[0].indexOf(max);

//   final pred = labels[posOfMax];
//   final confidence = (max * 100).toStringAsFixed(2);

//   showSmack(pred, confidence);

//   setState(() {
//     _isLoading = false;
//   });
// }

// void showSmack(String label, String confidence) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: RichText(
//           text: TextSpan(
//             text: "This image most likely belongs to ",
//             style: const TextStyle(fontSize: 18, color: Colors.black87),
//             children: [
//               TextSpan(
//                 text: label,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const TextSpan(text: " class. With "),
//               TextSpan(
//                 text: "$confidence%",
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const TextSpan(text: " confidence.")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
