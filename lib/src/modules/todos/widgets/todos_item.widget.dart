import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListItem extends ConsumerWidget {
  const TodoListItem({super.key, required this.todo, required this.docId});

  final Todo todo;
  final String docId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: const Color(0xffF4F6FD),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.delete, size: 32),
                SizedBox(width: 8),
                Text('The task was deleted'),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text('UNDO', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          title: Text(
            todo.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          leading: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: todo.done,
            onChanged: (value) {
              ref.read(todoCloudFirestoreRepositoryProvider).updateTodo(
                    docId,
                    todo.copyWith(done: value),
                  );
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      onDismissed: (direction) {
        ref.read(todoCloudFirestoreRepositoryProvider).delete(docId);
      },
    );
  }
}
