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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
      ),
      minLines: minLines,
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
    );
  }
}
