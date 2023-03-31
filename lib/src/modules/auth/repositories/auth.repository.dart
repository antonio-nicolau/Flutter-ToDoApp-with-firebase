import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/repositories/auth.repository.interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

final authStatusProvider = StreamProvider<String?>((ref) {
  ref.watch(authRepositoryProvider).authStatus().listen((event) {
    print('event:${event?.email}');
    ref.read(isAuthenticatedProvider.notifier).state = event?.email != null;
  });

  return ref.watch(authRepositoryProvider).authStatus().map((user) {
    return user?.email;
  });
});

final isAuthenticatedProvider = StateProvider<bool>((ref) {
  return ref.read(authRepositoryProvider).currentUser()?.email != null;
});

class AuthRepository implements IAuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  @override
  Future<bool> signInWithEmailAndPassword(UserModel user) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(email: user.email, password: user.password);
      return response.user != null;
    } on FirebaseAuthException catch (e) {
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
