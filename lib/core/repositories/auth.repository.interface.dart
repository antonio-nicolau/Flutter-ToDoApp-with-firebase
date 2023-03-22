import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cloud_firestore/core/models/user.model.dart';

abstract class IAuthRepository {
  Future<bool> login(UserModel user);
  void logout();
  Stream<User?> authStatus();
}
