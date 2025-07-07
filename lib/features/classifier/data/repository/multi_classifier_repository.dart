import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../model/prediction.dart';

class MultiModelClassifierRepository {
  late Interpreter _interpreter1;
  late Interpreter _interpreter2;

  late List<String> _labels1;
  late List<String> _labels2;

  final int inputSize = 224;

  Future<void> loadModels() async {
    _interpreter1 =
        await Interpreter.fromAsset('assets/ml/product/model.tflite');
    _interpreter2 = await Interpreter.fromAsset('assets/ml/color/model.tflite');

    _labels1 = (await rootBundle.loadString('assets/ml/product/labels.txt'))
        .split('\n');
    _labels2 =
        (await rootBundle.loadString('assets/ml/color/labels.txt')).split('\n');
  }

  Future<(Prediction, Prediction)> classify(File imageFile) async {
    final image = img.decodeImage(await imageFile.readAsBytes());
    if (image == null) throw Exception('Failed to decode image');
    final resized = img.copyResize(image, width: inputSize, height: inputSize);

    final input = Float32List(inputSize * inputSize * 3);
    int index = 0;
    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final pixel = resized.getPixel(x, y);
        input[index++] = img.getRed(pixel) / 255.0;
        input[index++] = img.getGreen(pixel) / 255.0;
        input[index++] = img.getBlue(pixel) / 255.0;
      }
    }

    final top1 = _runModel(_interpreter1, _labels1, input);
    final top2 = _runModel(_interpreter2, _labels2, input);

    return (top1, top2);
  }

  Prediction _runModel(
      Interpreter interpreter, List<String> labels, Float32List input) {
    final outputShape = interpreter.getOutputTensor(0).shape;
    final output = List.filled(outputShape[1], 0.0).reshape(outputShape);
    interpreter.run(input.reshape([1, inputSize, inputSize, 3]), output);

    double maxScore = -1;
    int maxIdx = -1;

    for (int i = 0; i < outputShape[1]; i++) {
      if (output[0][i] > maxScore) {
        maxScore = output[0][i];
        maxIdx = i;
      }
    }

    final label = (maxIdx < labels.length) ? labels[maxIdx] : 'Class $maxIdx';
    return Prediction(label: label, confidence: maxScore);
  }

  void dispose() {
    _interpreter1.close();
    _interpreter2.close();
  }
}
