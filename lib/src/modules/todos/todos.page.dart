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
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: const AddTodo(),
          );
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
              Icons.search_rounded,
              color: Color(0xff9D9AB4),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xff9D9AB4),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xffF4F6FD),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "What's up, António",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 40),
              const TodoCategories(),
              const SizedBox(height: 40),
              Text(
                "TODA'S TASKS",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
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

final categories = ['Business', 'Personal', 'Reading', 'Hang out'];

class TodoCategories extends ConsumerWidget {
  const TodoCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CATEGORIES",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Container(
                width: 160,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('20 tasks', style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 16),
                    Text(category, style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
