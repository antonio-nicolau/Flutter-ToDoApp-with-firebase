import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Hello Again!',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "Welcome back you've been missed",
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
