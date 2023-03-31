import 'package:flutter/material.dart';

class UnderlineText extends StatelessWidget {
  const UnderlineText({super.key, required this.text, this.textStyle});

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ??
          const TextStyle(
            color: Color(0xff9D9AB4),
            decoration: TextDecoration.underline,
          ),
    );
  }
}
