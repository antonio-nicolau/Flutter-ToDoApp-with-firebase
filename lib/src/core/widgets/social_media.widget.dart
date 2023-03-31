import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SocialMediaLogin extends ConsumerWidget {
  const SocialMediaLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.of(context)!.or_continue_with,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff9D9AB4),
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(child: Divider()),
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
