import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';

abstract class IAuthRepository {
  Future<bool> signInWithEmailAndPassword(UserModel user);
  void logout();
  Stream<User?> authStatus();
  User? currentUser();
}
