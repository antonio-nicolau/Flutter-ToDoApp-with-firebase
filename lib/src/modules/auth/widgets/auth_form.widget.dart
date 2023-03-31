import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/constants/enums.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/todo_textfield.widget.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

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
        ],
      ),
    );
  }
}
