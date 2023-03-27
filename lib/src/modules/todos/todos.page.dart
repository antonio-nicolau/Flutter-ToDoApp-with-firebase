import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/core/repositories/auth.repository.dart';
import 'package:flutter_cloud_firestore/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/add_todo.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser();

    final todosAsyncvalue = ref.watch(getTodosProvider);

    void displayModal() {
      showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (context) {
          return const AddTodo();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authRepositoryProvider).logout();
            },
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.98),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What's up, ${user?.displayName}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 20),
              todosAsyncvalue.when(
                data: (data) {
                  final docs = data.docs;
                  final todos = docs.map((e) => Todo.fromMap(e.data() as Map<String, dynamic>)).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];

                      return ListItem(todo: todo, docId: docs[index].id);
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Text(error.toString()),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: displayModal,
        tooltip: 'Add new todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListItem extends ConsumerWidget {
  const ListItem({super.key, required this.todo, required this.docId});

  final Todo todo;
  final String docId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
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
    );
  }
}
