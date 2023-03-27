import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/add_todo.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todo_search_delegate.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todos_categories.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todos_item.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsyncvalue = ref.watch(getTodosProvider);

    void displayModal() {
      showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: AddTodo(),
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
              showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                      todosAsyncvalue.asData!.value.docs.map((e) => Todo.fromMap(e.data() as Map<String, dynamic>)).toList()));
            },
            icon: const Icon(Icons.search_rounded, color: Color(0xff9D9AB4)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Color(0xff9D9AB4)),
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
                "TODAY'S TASKS",
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

                      return TodoListItem(todo: todo, docId: docs[index].id);
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
