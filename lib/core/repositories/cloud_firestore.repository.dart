import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cloud_firestore/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/core/repositories/cloud_firestore.repository.interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final todoCloudFirestoreRepositoryProvider = Provider<ICloudFirestoreRepository>((ref) {
  return TodoCloudFirestoreRepository(FirebaseFirestore.instance);
});

final getTodosProvider = StreamProvider.autoDispose<QuerySnapshot>((ref) {
  return ref.read(todoCloudFirestoreRepositoryProvider).getTodos();
});

class TodoCloudFirestoreRepository implements ICloudFirestoreRepository {
  final FirebaseFirestore _db;

  const TodoCloudFirestoreRepository(this._db);

  @override
  Stream<QuerySnapshot> getTodos() {
    return _db.collection('todos').snapshots();
  }

  @override
  Future<void> add(Todo todo) async {
    await _db.collection('todos').add(todo.toMap());
  }

  @override
  Future<void> delete(String uuid) async {
    _db.collection('todos').doc(uuid).delete();
  }
}
