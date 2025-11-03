import 'package:flutter/material.dart';
import 'package:visual_search/core/theme/app_pallete.dart';

import 'flickering_opacity.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.fitHeight,
            height: 120,
          ),
          Text(
            "Visual Search",
            style: TextStyle(
              color: AppPallete.buttonBlueColor,
              fontFamily: "Grandis Extended",
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AuthLoader extends StatelessWidget {
  const AuthLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlickeringOpacity(
            duration: Duration(milliseconds: 500),
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fitHeight,
              height: 120,
            ),
          ),
          Text(
            "Visual Search",
            style: TextStyle(
              color: AppPallete.buttonBlueColor,
              fontFamily: "Grandis Extended",
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class LogoLoader extends StatelessWidget {
  const LogoLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlickeringOpacity(
            duration: Duration(milliseconds: 500),
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fitHeight,
              height: 60,
            ),
          ),
        ],
      ),
    );
  }
}
