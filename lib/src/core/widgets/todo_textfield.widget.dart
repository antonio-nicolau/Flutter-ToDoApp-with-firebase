import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TodoTextInputType { email, date, password, text, profile }

class TodoTextField extends ConsumerWidget {
  TodoTextField({
    super.key,
    required this.controller,
    this.label,
    this.minLines,
    this.maxLines,
    this.hintText,
    this.enableBorder = true,
    this.obscureText = false,
    this.hintTextStyle,
    this.textInputType = TodoTextInputType.text,
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
  final TodoTextInputType textInputType;
  final bool obscureText;
  final Color? fillColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = ref.watch(showPasswordProvider);
    final isPasswordField = textInputType == TodoTextInputType.password;

    final keyboardType = _getKeyboardType(textInputType);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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
        suffixIcon: isPasswordField
            ? IconButton(
                onPressed: () {
                  ref.read(showPasswordProvider.notifier).state = !showPassword;
                },
                icon: Icon(
                  showPassword == true ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xff9D9AB4),
                ),
              )
            : const SizedBox.shrink(),
      ),
      minLines: minLines,
      maxLines: maxLines ?? 1,
      obscureText: isPasswordField && !showPassword,
      onChanged: onChanged,
    );
  }

  final showPasswordProvider = StateProvider<bool>((ref) {
    return false;
  });

  TextInputType _getKeyboardType(TodoTextInputType textInputType) {
    switch (textInputType) {
      case TodoTextInputType.email:
        return TextInputType.emailAddress;
      case TodoTextInputType.password:
        return TextInputType.visiblePassword;

      default:
        return TextInputType.text;
    }
  }
}
