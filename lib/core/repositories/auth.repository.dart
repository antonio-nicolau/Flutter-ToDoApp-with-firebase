import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cloud_firestore/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/core/repositories/auth.repository.interface.dart';
import 'package:flutter_cloud_firestore/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/core/repositories/cloud_firestore.repository.interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final firestoreRepository = ref.read(todoCloudFirestoreRepositoryProvider);
  return AuthRepository(FirebaseAuth.instance, firestoreRepository);
});

final authStatusProvider = StreamProvider<String?>((ref) {
  ref.watch(authRepositoryProvider).authStatus().listen((event) {
    ref.invalidate(isAuthenticatedProvider);
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
  final ICloudFirestoreRepository _firestoreRepository;

  AuthRepository(this._firebaseAuth, this._firestoreRepository);

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

  @override
  Future<UserModel?> createUserWithEmailAndPassword(UserModel user) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );

    if (credential.user != null) return user.copyWith(id: credential.user?.uid);

    return null;
  }

  @override
  Future<void> signUpWithEmailAndPassword(UserModel user) async {
    try {
      final response = await createUserWithEmailAndPassword(user);

      if (response != null) {
        await _firestoreRepository.saveUserProfile(response);
      }
    } on FirebaseAuthException catch (e) {
      log('An error while creating user: ${e.message} - ${e.code}');
    } catch (e) {
      log(e.toString());
    }
  }
}
