import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/core/widgets/todo_elevated_button.widget.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F0F6),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'src/to_do_home.jpg',
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Discover your',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Best task manager here',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Explore all the most exiting ways to manage your todo with an interactive UI',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: const Color(0xff9D9AB4),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TodoElevatedButton(
                          onPressed: () {
                            context.router.push(const RegisterRoute());
                          },
                          borderRadius: 8,
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white,
                          child: const Text(
                            'Register',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TodoElevatedButton(
                          onPressed: () {
                            context.router.push(const AuthRoute());
                          },
                          backgroundColor: const Color(0xffF1F0F6),
                          borderRadius: 8,
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
