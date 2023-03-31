import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/constants/enums.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/todo_textfield.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/sign_up/widgets/sign_up_terms_and_conditions.widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TodoTextField(
            controller: nameController,
            label: AppLocalizations.of(context)!.your_name,
            labelTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xff9D9AB4)),
          ),
          const SizedBox(height: 30),
          TodoTextField(
            textInputType: TodoTextInputType.email,
            controller: emailController,
            label: AppLocalizations.of(context)!.enter_username,
            labelTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xff9D9AB4)),
          ),
          const SizedBox(height: 16),
          TodoTextField(
            textInputType: TodoTextInputType.password,
            controller: passwordController,
            label: AppLocalizations.of(context)!.password,
            obscureText: true,
            labelTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xff9D9AB4)),
          ),
          const SizedBox(height: 8),
          const SignUpTermsAndConditions(),
        ],
      ),
    );
  }
}
