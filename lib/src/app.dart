import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/src/modules/home/home.page.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _appRouter.config(initialRoutes: [const HomeRoute()]),
    );
  }
}
