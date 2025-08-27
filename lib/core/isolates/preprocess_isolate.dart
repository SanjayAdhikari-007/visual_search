import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'preprocess_params.dart';

Float32List preprocessImage(PreprocessParams params) {
  final image = img.decodeImage(params.bytes);
  if (image == null) throw Exception('Failed to decode image');
  final resized =
      img.copyResize(image, width: params.inputSize, height: params.inputSize);

  final input = Float32List(params.inputSize * params.inputSize * 3);
  int index = 0;
  for (int y = 0; y < params.inputSize; y++) {
    for (int x = 0; x < params.inputSize; x++) {
      final pixel = resized.getPixel(x, y);
      input[index++] = img.getRed(pixel) / 255.0;
      input[index++] = img.getGreen(pixel) / 255.0;
      input[index++] = img.getBlue(pixel) / 255.0;
    }
  }

  return input;
}
