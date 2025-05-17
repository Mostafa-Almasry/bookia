import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final BoxConstraints? suffixIconConstraints;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final bool? autoFocus;

  const CustomTextFormField({
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    super.key,
    this.suffixIconConstraints,
    this.minLines,
    this.maxLines,
    this.keyboardType,
    this.autoFocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
      ),
      minLines: minLines ?? 1,
      maxLines: maxLines ?? (obscureText ? 1 : null),
      keyboardType: keyboardType ?? TextInputType.text,
      autofocus: autoFocus ?? false,
      
    );
  }
}
