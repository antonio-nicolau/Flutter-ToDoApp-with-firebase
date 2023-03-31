import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/src/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/core/repositories/cloud_firestore.repository.interface.dart';
import 'package:flutter_cloud_firestore/src/modules/sign_up/repositories/sign_up.repository.interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpRepositoryProvider = Provider<ISignUpRepository>((ref) {
  final firestoreRepository = ref.read(cloudFirestoreRepositoryProvider);
  return SignUpRepository(FirebaseAuth.instance, firestoreRepository);
});

class SignUpRepository implements ISignUpRepository {
  final FirebaseAuth _firebaseAuth;
  final ICloudDatabaseRepository _firestoreRepository;

  SignUpRepository(this._firebaseAuth, this._firestoreRepository);

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
