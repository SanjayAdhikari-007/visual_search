import 'package:flutter/material.dart';
import 'package:visual_search/core/theme/app_pallete.dart';

class Constants {
  static const List<String> topics = [
    'Technology',
    'Business',
    'Programming',
    'Entertainment',
  ];

  static const noConnectionErrorMessage = 'Not connected to a network!';

  static const String baseApiUrl = "https://e-com-api-zeta.vercel.app/api";
}

const double defaultPadding = 16.0;
const Duration defaultDuration = Duration(milliseconds: 300);
const Color primaryColor = AppPallete.buttonBlueColor;
const Color errorColor = Color(0xFFEA5B5B);
const double defaultBorderRadious = 12.0;
