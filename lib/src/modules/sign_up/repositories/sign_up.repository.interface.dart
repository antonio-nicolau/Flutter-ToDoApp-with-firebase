
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';

abstract class ISignUpRepository {
  Future<UserModel?> createUserWithEmailAndPassword(UserModel user);
  Future<void> signUpWithEmailAndPassword(UserModel user);
}
