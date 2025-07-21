import 'package:equatable/equatable.dart';
import '../../data/model/prediction.dart';
import 'dart:io';

abstract class ClassifierState extends Equatable {
  const ClassifierState();

  @override
  List<Object?> get props => [];
}

class ClassifierInitial extends ClassifierState {}

class ClassifierLoading extends ClassifierState {}

class ClassifierSuccess extends ClassifierState {
  final File imageFile;
  final (Prediction, Prediction, Prediction) predictions;

  const ClassifierSuccess({required this.imageFile, required this.predictions});

  @override
  List<Object?> get props => [imageFile, predictions];
}

class ClassifierError extends ClassifierState {
  final String message;

  const ClassifierError(this.message);

  @override
  List<Object?> get props => [message];
}
