import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/constants/enums.dart';
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/src/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/todo_elevated_button.widget.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/social_media.widget.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/todo_textfield.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/repositories/auth.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestStatus = ref.watch(authRequestStatusProvider);
    final emailEdittingController = TextEditingController();
    final passwordEdittingController = TextEditingController();

    Future<void> signInWithEmailAndPassword() async {
      final email = emailEdittingController.text.trim();
      final password = passwordEdittingController.text.trim();

      final user = UserModel(email: email, password: password);

      final response = await ref.read(authRepositoryProvider).signInWithEmailAndPassword(user);

      if (context.mounted) {
        if (response) {
          ref.read(isAuthenticatedProvider.notifier).state = true;
          context.router.push(const TodosRoute());
        }
      }
    }

    ref.listen<RequestStatus>(authRequestStatusProvider, (previous, next) {
      if (next == RequestStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email or password incorrect'),
        ));
      }
    });

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
                  'Hello Again!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  "Welcome back you've been missed",
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Recover Password',
                      style: TextStyle(
                        color: Color(0xff9D9AB4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TodoElevatedButton(
                  backgroundColor: const Color(0xffE1372D),
                  elevation: 0,
                  onPressed: signInWithEmailAndPassword,
                  child: requestStatus != RequestStatus.loading ? const Text('Sign in') : buttonSpinner(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 40),
                  child: SocialMediaLogin(),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?'),
                    SizedBox(width: 10),
                    Text(
                      'Register now',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
