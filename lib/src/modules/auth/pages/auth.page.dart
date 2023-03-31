import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/constants/enums.dart';
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/src/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/todo_elevated_button.widget.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/social_media.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/repositories/auth.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/widgets/auth_form.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/widgets/auth_header.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestStatus = ref.watch(authRequestStatusProvider);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    Future<void> signInWithEmailAndPassword() async {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

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
                const AuthHeader(),
                const SizedBox(height: 30),
                AuthForm(
                  formKey: _formKey,
                  emailController: emailController,
                  passwordController: passwordController,
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
                  enable: requestStatus != RequestStatus.loading,
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
