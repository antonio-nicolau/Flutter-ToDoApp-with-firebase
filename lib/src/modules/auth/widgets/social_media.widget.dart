import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SocialMediaLogin extends ConsumerWidget {
  const SocialMediaLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(child: Divider()),
            SizedBox(width: 8),
            Text(
              'Or continue with',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff9D9AB4),
              ),
            ),
            SizedBox(width: 8),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 32),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(width: 2, color: Colors.white),
            ),
            width: 70,
            height: 70,
            child: Image.network(
              'http://pngimg.com/uploads/google/google_PNG19635.png',
              width: 45,
              height: 45,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(width: 2, color: Colors.white),
            ),
            width: 70,
            height: 70,
            child: const Icon(Icons.apple, color: Colors.black, size: 45),
          ),
          const SizedBox(width: 16),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(width: 2, color: Colors.white),
            ),
            width: 70,
            height: 70,
            child: const Icon(Icons.facebook, color: Colors.blue, size: 45),
          ),
        ]),
      ],
    );
  }
}
