import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/modules/sign_up/widgets/underline_text.widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpTermsAndConditions extends ConsumerWidget {
  const SignUpTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Wrap(
        children: [
          Text(
            AppLocalizations.of(context)!.terms_and_conditions_1,
            style: const TextStyle(color: Color(0xff9D9AB4)),
          ),
          const SizedBox(width: 8),
          UnderlineText(text: AppLocalizations.of(context)!.terms_and_conditions_2),
          const SizedBox(width: 8),
          Text(
            AppLocalizations.of(context)!.and,
            style: const TextStyle(color: Color(0xff9D9AB4)),
          ),
          const SizedBox(width: 8),
          UnderlineText(text: AppLocalizations.of(context)!.terms_and_conditions_3),
        ],
      ),
    );
  }
}
