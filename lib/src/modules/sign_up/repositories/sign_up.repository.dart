import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cloud_firestore/src/core/constants/enums.dart';
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/src/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/sign_up/repositories/sign_up.repository.interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpRepositoryProvider = Provider<ISignUpRepository>((ref) {
  return SignUpRepository(FirebaseAuth.instance, ref);
});

final signUpRequestStatusProvider = StateProvider.autoDispose<RequestStatus>((ref) {
  return RequestStatus.none;
});

class SignUpRepository implements ISignUpRepository {
  final FirebaseAuth _firebaseAuth;
  final Ref _ref;

  SignUpRepository(this._firebaseAuth, this._ref);

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
    _ref.read(signUpRequestStatusProvider.notifier).state = RequestStatus.loading;
    try {
      final response = await createUserWithEmailAndPassword(user);

      if (response != null) {
        await _ref.read(cloudFirestoreRepositoryProvider).saveUserProfile(response);
        _ref.read(signUpRequestStatusProvider.notifier).state = RequestStatus.success;
      }
    } on FirebaseAuthException catch (e) {
      log('An error while creating user: ${e.message} - ${e.code}');
      _ref.read(signUpRequestStatusProvider.notifier).state = RequestStatus.error;
    } catch (e) {
      log(e.toString());
      _ref.read(signUpRequestStatusProvider.notifier).state = RequestStatus.error;
    }
  }
}
