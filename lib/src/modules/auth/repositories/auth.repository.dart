import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cloud_firestore/src/core/constants/enums.dart';
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/repositories/auth.repository.interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance, ref);
});

final currentUserProvider = StateProvider<User?>((ref) {
  return ref.read(authRepositoryProvider).currentUser();
});

final authStatusProvider = StreamProvider<String?>((ref) {
  ref.watch(authRepositoryProvider).authStatus().listen((event) {
    print('event:${event?.email}');
    ref.read(isAuthenticatedProvider.notifier).state = event?.email != null;
    ref.read(currentUserProvider.notifier).state = event;
  });

  return ref.watch(authRepositoryProvider).authStatus().map((user) {
    return user?.email;
  });
});

final isAuthenticatedProvider = StateProvider<bool>((ref) {
  return ref.read(authRepositoryProvider).currentUser()?.email != null;
});

final authRequestStatusProvider = StateProvider.autoDispose<RequestStatus>((ref) {
  return RequestStatus.none;
});

class AuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final Ref _ref;

  AuthRepository(this._firebaseAuth, this._ref);

  @override
  Future<bool> signInWithEmailAndPassword(UserModel user) async {
    _ref.read(authRequestStatusProvider.notifier).state = RequestStatus.loading;
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(email: user.email, password: user.password);
      _ref.read(authRequestStatusProvider.notifier).state = RequestStatus.success;
      return response.user != null;
    } on FirebaseAuthException catch (e) {
      _ref.read(authRequestStatusProvider.notifier).state = RequestStatus.error;

      switch (e.code) {
        case 'user-not-found':
          break;
        case 'invalid-email':
          break;
        case 'wrong-password':
          break;
        default:
      }
      log(e.code);
    } catch (e) {
      _ref.read(authRequestStatusProvider.notifier).state = RequestStatus.error;
      log(e.toString());
    }
    return false;
  }

  @override
  void logout() {
    _firebaseAuth.signOut();
  }

  @override
  Stream<User?> authStatus() {
    return _firebaseAuth.authStateChanges();
  }

  @override
  User? currentUser() => _firebaseAuth.currentUser;
}
