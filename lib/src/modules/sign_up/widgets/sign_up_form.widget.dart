import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/todo_textfield.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/sign_up/widgets/underline_text.widget.dart';

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
            label: 'Your name',
            labelTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xff9D9AB4)),
          ),
          const SizedBox(height: 30),
          TodoTextField(
            textInputType: TodoTextInputType.email,
            controller: emailController,
            label: 'Enter username',
            labelTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xff9D9AB4)),
          ),
          const SizedBox(height: 16),
          TodoTextField(
            textInputType: TodoTextInputType.password,
            controller: passwordController,
            label: 'Password',
            obscureText: true,
            labelTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xff9D9AB4)),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
            child: Wrap(
              children: [
                Text(
                  'By singing up, you agree to the',
                  style: TextStyle(color: Color(0xff9D9AB4)),
                ),
                SizedBox(width: 8),
                UnderlineText(text: 'Terms of Service'),
                SizedBox(width: 8),
                Text(
                  'and',
                  style: TextStyle(color: Color(0xff9D9AB4)),
                ),
                SizedBox(width: 8),
                UnderlineText(text: 'Privacy Policy'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
