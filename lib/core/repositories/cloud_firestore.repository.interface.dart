import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cloud_firestore/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/core/models/user.model.dart';

abstract class ICloudFirestoreRepository {
  Stream<QuerySnapshot> getTodos();
  Future<void> add(Todo todo);
  Future<void> delete(String uuid);
  Future<void> updateTodo(String uuid, Todo todo);
  Future<void> saveUserProfile(UserModel user);
}
