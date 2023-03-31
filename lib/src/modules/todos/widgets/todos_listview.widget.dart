import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/src/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todos_item.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TodosListView extends ConsumerWidget {
  const TodosListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsyncValue = ref.watch(getTodosProvider);

    return todosAsyncValue.when(
      data: (data) {
        final docs = data.docs;

        if (docs.isEmpty) {
          return const TodoEmptyListView();
        }

        final todos = docs.map((e) => Todo.fromJson(e.data() as Map<String, dynamic>)).toList();

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
    );
  }
}

class TodoEmptyListView extends StatelessWidget {
  const TodoEmptyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 200, width: 200, child: Image.asset('src/empty_page.png')),
          Text(
            AppLocalizations.of(context)!.empty_list_title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.empty_list_subtitle,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
