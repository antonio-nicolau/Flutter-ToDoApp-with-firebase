import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/repositories/auth.repository.dart';
import 'package:flutter_cloud_firestore/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/src/modules/home/home.page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    return MaterialApp.router(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        iconTheme: const IconThemeData(color: Color(0xff9D9AB4)),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: Color(0xff9D9AB4)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: ref.read(appRouterProvider).config(
        initialRoutes: [
          if (isAuthenticated) const TodosRoute() else const HomeRoute(),
        ],
      ),
    );
  }
}
