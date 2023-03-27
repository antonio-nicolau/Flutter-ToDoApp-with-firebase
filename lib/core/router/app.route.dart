import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/router/auth_guard.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/auth.page.dart';
import 'package:flutter_cloud_firestore/src/modules/home/home.page.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/todos.page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app.route.gr.dart';

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter(ref);
});

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final Ref _ref;

  AppRouter(this._ref);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: TodosRoute.page),
      ];
}
