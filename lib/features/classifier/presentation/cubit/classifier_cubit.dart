import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/multi_classifier_repository.dart';
import 'classifier_state.dart';

class ClassifierCubit extends Cubit<ClassifierState> {
  final MultiModelClassifierRepository _repository;
  String filePath = "";

  bool _isInitialized = false;
  ClassifierCubit(this._repository) : super(ClassifierInitial());

  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      await _repository.loadModels();
      _isInitialized = true;
    } catch (e) {
      emit(ClassifierError('Model loading failed: $e'));
    }
  }

  Future<void> classify(File imageFile) async {
    filePath = imageFile.path;
    emit(ClassifierLoading());

    try {
      if (!_isInitialized) {
        await _repository
            .loadModels(); // fallback in case initialize wasn't called
        _isInitialized = true;
      }

      final (p1, p2, p3) = await _repository.classify(imageFile);
      emit(ClassifierSuccess(imageFile: imageFile, predictions: (p1, p2, p3)));
    } catch (e) {
      emit(ClassifierError('Classification failed: $e'));
    }
  }

  void removeImage() {
    filePath = "";
    emit(ClassifierInitial());
  }
}
