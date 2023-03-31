import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Hi here! Let's",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "get started",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
