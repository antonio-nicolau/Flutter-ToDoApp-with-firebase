import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cloud_firestore/src/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/src/core/models/user.model.dart';
import 'package:flutter_cloud_firestore/src/core/repositories/cloud_firestore.repository.interface.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/repositories/auth.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cloudFirestoreRepositoryProvider = Provider<ICloudDatabaseRepository>((ref) {
  return CloudFirestoreRepository(FirebaseFirestore.instance, ref);
});

final getTodosProvider = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  final uid = ref.read(authRepositoryProvider).currentUser()?.uid;
  return ref.read(cloudFirestoreRepositoryProvider).getTodosByUserId(uid ?? '');
});

final getUserProfileProvider = FutureProvider.autoDispose<UserModel>((ref) async {
  return ref.read(cloudFirestoreRepositoryProvider).getUserProfile();
});

class CloudFirestoreRepository implements ICloudDatabaseRepository {
  final FirebaseFirestore _db;
  final Ref _ref;

  const CloudFirestoreRepository(this._db, this._ref);

  @override
  Stream<QuerySnapshot> getTodosByUserId(String userId) {
    return _db.collection('todos').where('userId', isEqualTo: userId).snapshots();
  }

  @override
  Future<void> add(Todo todo) async {
    await _db.collection('todos').add(todo.toJson());
  }

  @override
  Future<void> delete(String uuid) async {
    _db.collection('todos').doc(uuid).delete();
  }

  @override
  Future<void> updateTodo(String uuid, Todo todo) async {
    _db.collection('todos').doc(uuid).update(todo.toJson());
  }

  @override
  Future<void> saveUserProfile(UserModel user) async {
    await _db.collection('users').add(user.toJson());
  }

  @override
  Future<UserModel> getUserProfile() async {
    final userId = _ref.read(authRepositoryProvider).currentUser()?.uid;
    final response = await _db.collection('users').where('id', isEqualTo: userId).get();

    return UserModel.fromJson(response.docs.first.data());
  }
}
