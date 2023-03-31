import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/src/core/repositories/auth.repository.dart';
import 'package:flutter_cloud_firestore/src/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/todo_elevated_button.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/widgets/social_media.widget.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/todo_textfield.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameEdittingController = TextEditingController();
    final emailEdittingController = TextEditingController();
    final passwordEdittingController = TextEditingController();

    Future<void> register() async {
      final name = nameEdittingController.text.trim();
      final email = emailEdittingController.text.trim();
      final password = passwordEdittingController.text.trim();

      final user = UserModel(
        name: name,
        email: email,
        password: password,
      );

      await ref.read(authRepositoryProvider).signUpWithEmailAndPassword(user);

      if (context.mounted) {
        context.router.push(const AuthRoute());
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xffF1F0F6),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                const SizedBox(height: 30),
                TodoTextField(
                  controller: nameEdittingController,
                  label: 'Your name',
                  labelTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xff9D9AB4)),
                ),
                const SizedBox(height: 30),
                TodoTextField(
                  textInputType: TodoTextInputType.email,
                  controller: emailEdittingController,
                  label: 'Enter username',
                  labelTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xff9D9AB4)),
                ),
                const SizedBox(height: 16),
                TodoTextField(
                  textInputType: TodoTextInputType.password,
                  controller: passwordEdittingController,
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
                const SizedBox(height: 16),
                TodoElevatedButton(
                  backgroundColor: const Color(0xffE1372D),
                  elevation: 0,
                  onPressed: register,
                  child: const Text('Sign up'),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 40),
                  child: SocialMediaLogin(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
