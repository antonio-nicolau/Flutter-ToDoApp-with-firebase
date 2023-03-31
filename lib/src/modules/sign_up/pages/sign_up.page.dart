import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/constants/enums.dart';
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/src/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/todo_elevated_button.widget.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/social_media.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/sign_up/repositories/sign_up.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/sign_up/widgets/sign_up_form.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/sign_up/widgets/sign_up_header.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestStatus = ref.watch(signUpRequestStatusProvider);
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    Future<void> signUpWithPassword() async {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final user = UserModel(name: name, email: email, password: password);

      await ref.read(signUpRepositoryProvider).signUpWithEmailAndPassword(user);

      if (context.mounted && ref.read(signUpRequestStatusProvider) == RequestStatus.success) {
        context.router.push(const AuthRoute());
      }
    }

    ref.listen<RequestStatus>(signUpRequestStatusProvider, (previous, next) {
      if (next == RequestStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error while creating account'),
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
                const SignUpHeader(),
                const SizedBox(height: 30),
                SignUpForm(
                  formKey: _formKey,
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(height: 16),
                TodoElevatedButton(
                  enable: requestStatus != RequestStatus.loading,
                  backgroundColor: const Color(0xffE1372D),
                  elevation: 0,
                  onPressed: signUpWithPassword,
                  child: requestStatus != RequestStatus.loading ? const Text('Sign up') : buttonSpinner(),
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
