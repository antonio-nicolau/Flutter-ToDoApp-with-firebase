import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/repositories/auth.repository.dart';
import 'package:flutter_cloud_firestore/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/core/utils/dark_theme.dart';
import 'package:flutter_cloud_firestore/core/utils/theme_preferences.dart';
import 'package:flutter_cloud_firestore/core/utils/light_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    checkIfIsDarkTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    return MaterialApp.router(
      title: 'Todo App',
      theme: isDarkTheme ? darkTheme(context) : lightTheme(context),
      debugShowCheckedModeBanner: false,
      routerConfig: ref.read(appRouterProvider).config(
        initialRoutes: [
          if (isAuthenticated) const TodosRoute() else const HomeRoute(),
        ],
      ),
    );
  }

  void checkIfIsDarkTheme() {
    DarkThemePreference().getTheme().then((value) {
      ref.read(isDarkThemeProvider.notifier).state = value;
    });
  }
}
