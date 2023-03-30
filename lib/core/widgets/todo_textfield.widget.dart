import 'package:flutter/material.dart';

class TodoTextField extends StatelessWidget {
  const TodoTextField({
    super.key,
    required this.controller,
    this.label,
    this.minLines,
    this.maxLines,
    this.hintText,
    this.enableBorder = true,
    this.obscureText = false,
    this.hintTextStyle,
    this.textInputType,
    this.labelTextStyle,
    this.fillColor,
    this.onChanged,
  });
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final bool enableBorder;
  final Function(String value)? onChanged;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final TextInputType? textInputType;
  final bool obscureText;
  final Color? fillColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(
        label: Text(label ?? ''),
        hintText: hintText,
        filled: true,
        fillColor: fillColor ?? Colors.white,
        labelStyle: labelTextStyle ?? Theme.of(context).textTheme.headlineSmall?.copyWith(color: const Color(0xff9D9AB4)),
        hintStyle: hintTextStyle ?? Theme.of(context).textTheme.headlineSmall?.copyWith(color: const Color(0xff9D9AB4)),
        focusedBorder: enableBorder == true
            ? OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(16),
              )
            : InputBorder.none,
        enabledBorder: enableBorder == true
            ? OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(16),
              )
            : InputBorder.none,
      ),
      minLines: minLines,
      maxLines: maxLines ?? 1,
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }
}
