import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cloud_firestore/core/models/user.model.dart';

abstract class IAuthRepository {
  Future<bool> signInWithEmailAndPassword(UserModel user);
  Future<UserModel?> createUserWithEmailAndPassword(UserModel user);
  Future<void> signUpWithEmailAndPassword(UserModel user);
  void logout();
  Stream<User?> authStatus();
  User? currentUser();
}
