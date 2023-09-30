import 'package:flutter/material.dart';

import 'package:step_counter/screens/components/app_dimensions.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?) validator;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String labelText;
  final String hintText;
  final bool isObscureText;

  const CustomTextFormField({
    Key? key,
    required this.validator,
    required this.controller,
    required this.textInputType,
    required this.labelText,
    required this.hintText,
    required this.isObscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          AppDimensions.horizontalPadding16 + AppDimensions.verticalPadding16,
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType,
        validator: validator,
        obscureText: isObscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
