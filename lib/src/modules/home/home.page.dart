import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/src/core/widgets/todo_elevated_button.widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
                    AppLocalizations.of(context)!.home_title_1,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.home_title_2,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.home_subtitle,
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
                            context.router.push(const SignUpRoute());
                          },
                          borderRadius: 8,
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white,
                          child: Text(
                            AppLocalizations.of(context)!.sign_up,
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                          child: Text(
                            AppLocalizations.of(context)!.sign_in,
                            style: const TextStyle(
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
