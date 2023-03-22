import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/core/repositories/auth.repository.dart';
import 'package:flutter_cloud_firestore/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todo_textfield.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailEdittingController = TextEditingController();
    final passwordEdittingController = TextEditingController();

    Future<void> login() async {
      final email = emailEdittingController.text.trim();
      final password = passwordEdittingController.text.trim();

      final user = UserModel(email: email, password: password);

      final response = await ref.read(authRepositoryProvider).login(user);

      if (context.mounted) {
        if (response) {
          context.router.push(const TodosRoute());
        }
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Login to your account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TodoTextField(
                controller: emailEdittingController,
                label: 'Email',
              ),
              const SizedBox(height: 16),
              TodoTextField(
                controller: passwordEdittingController,
                label: 'Password',
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Do not have an account yet? create one'),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
