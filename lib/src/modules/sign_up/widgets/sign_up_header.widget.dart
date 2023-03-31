import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/utils/theme_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpHeader extends ConsumerWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);

    return Column(
      children: [
        Text(
          AppLocalizations.of(context)!.sign_up_header_title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: !isDarkTheme ? Colors.black : Colors.white,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          AppLocalizations.of(context)!.sign_up_header_subtitle,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
