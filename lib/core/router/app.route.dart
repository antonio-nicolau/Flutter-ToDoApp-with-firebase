import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/auth.page.dart';
import 'package:flutter_cloud_firestore/src/modules/home/home.page.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/todos.page.dart';

part 'app.route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [AutoRoute(page: HomeRoute.page), AutoRoute(page: AuthRoute.page), AutoRoute(page: TodosRoute.page)];
}
