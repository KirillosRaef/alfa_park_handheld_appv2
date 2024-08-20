import 'package:flutter/material.dart';

class ValidationField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final TextInputType keyboardType;
  final bool validate;
  final Widget? suffixIcon;

  const ValidationField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
    this.validate = true,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        suffixIcon: suffixIcon,
      ),
      validator: (value) {
        if (!validate) {
          return null;
        }
        if (value!.isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
      obscureText: isObscureText,
      obscuringCharacter: '*',
      keyboardType: keyboardType,
    );
  }
}
