import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visual_search/core/common/color_print/color_print.dart';
import '../cubit/classifier_cubit.dart';
import '../cubit/classifier_state.dart';

class ClassifierScreen extends StatelessWidget {
  const ClassifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Classifier')),
      body: BlocBuilder<ClassifierCubit, ClassifierState>(
        builder: (context, state) {
          if (state is ClassifierLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ClassifierSuccess) {
            print(state.predictions.$1.label.split(" ").last);
            print(state.predictions.$2.label.split(" ").last);
            return Column(
              children: [
                Image.file(state.imageFile, height: 200),
                Text(state.predictions.$1.label.split(" ").last),
                Text(state.predictions.$2.label.split(" ").last),
              ],
            );
          } else if (state is ClassifierError) {
            return Center(child: Text(state.message));
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final picked =
                      await picker.pickImage(source: ImageSource.gallery);
                  printY(picked.toString());

                  if (picked != null) {
                    printY(picked.path);
                    // ignore: use_build_context_synchronously
                    await context
                        .read<ClassifierCubit>()
                        .classify(File(picked.path));
                  }
                },
                child: const Text('Upload Image'),
              ),
            );
          }
        },
      ),
    );
  }
}
