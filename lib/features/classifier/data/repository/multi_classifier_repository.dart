import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:visual_search/core/common/color_print/color_print.dart';

import '../../../../core/isolates/preprocess_isolate.dart';
import '../../../../core/isolates/preprocess_params.dart';
import '../model/prediction.dart';

class MultiModelClassifierRepository {
  late Interpreter _interpreter1;
  late Interpreter _interpreter2;
  late Interpreter _interpreter3;

  late List<String> _labels1;
  late List<String> _labels2;
  late List<String> _labels3;

  final int inputSize = 224;

  Future<void> loadModels() async {
    final results = await Future.wait([
      Interpreter.fromAsset('assets/ml/category/model.tflite'),
      Interpreter.fromAsset('assets/ml/color/model.tflite'),
      Interpreter.fromAsset('assets/ml/pattern/model.tflite'),
      rootBundle.loadString('assets/ml/category/labels.txt'),
      rootBundle.loadString('assets/ml/color/labels.txt'),
      rootBundle.loadString('assets/ml/pattern/labels.txt'),
    ]);

    _interpreter1 = results[0] as Interpreter;
    _interpreter2 = results[1] as Interpreter;
    _interpreter3 = results[2] as Interpreter;

    _labels1 = (results[3] as String).split('\n');
    _labels2 = (results[4] as String).split('\n');
    _labels3 = (results[5] as String).split('\n');
  }

  Future<(Prediction, Prediction, Prediction)> classify(File imageFile) async {
    final bytes = await imageFile.readAsBytes();

    final input = await compute(
      preprocessImage,
      PreprocessParams(bytes, inputSize),
    );

    final top1 = _runModel(_interpreter1, _labels1, input);
    final top2 = _runModel(_interpreter2, _labels2, input);
    final top3 = _runModel(_interpreter3, _labels3, input);

    return (top1, top2, top3);
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
    printG("Label: ${label} Confidence: ${maxScore}");
    return Prediction(label: label, confidence: maxScore);
  }

  void dispose() {
    _interpreter1.close();
    _interpreter2.close();
    _interpreter3.close();
  }
}
