import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 5,
        children: [
          Center(child: CircularProgressIndicator()),
          Text("Loading"),
        ],
      ),
    ),
  );
}
