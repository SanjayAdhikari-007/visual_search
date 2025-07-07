import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/constants.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final String icon;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.icon,
      this.isObscureText = false,
      this.inputType = TextInputType.text,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      textInputAction: TextInputAction.next,
      keyboardType: inputType,
      obscureText: isObscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
          child: SvgPicture.asset(
            icon,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
                Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withValues(alpha: 0.3),
                BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
