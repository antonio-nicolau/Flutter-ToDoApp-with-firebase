import 'package:flutter/material.dart';

class TodoTextField extends StatelessWidget {
  const TodoTextField({
    super.key,
    required this.controller,
    this.label,
    this.minLines,
    this.maxLines,
    this.hintText,
    this.onChanged,
  });
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label ?? ''),
        hintText: hintText,
        labelStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: const Color(0xff9D9AB4)),
        hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(color: const Color(0xff9D9AB4)),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      minLines: minLines,
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
    );
  }
}
