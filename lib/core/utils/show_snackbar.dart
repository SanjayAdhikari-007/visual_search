import 'package:flutter/material.dart';
import 'package:visual_search/core/theme/app_pallete.dart';

void showSnackBar(BuildContext context, String content,
    {bgColor = AppPallete.gradient2}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      ),
    );
}
