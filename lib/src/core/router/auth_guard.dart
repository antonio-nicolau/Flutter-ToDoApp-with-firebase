import 'package:auto_route/auto_route.dart';
import 'package:flutter_cloud_firestore/src/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/repositories/auth.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGuard extends AutoRouteGuard {
  final Ref _ref;

  const AuthGuard(this._ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_ref.read(isAuthenticatedProvider)) {
      resolver.next(true);
    } else {
      router.push(const HomeRoute());
    }
  }
}
