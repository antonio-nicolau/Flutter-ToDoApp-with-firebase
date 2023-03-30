import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/add_todo/pages/add_todo.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todo_search_delegate.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todo_side_menu.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todos_header.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todos_item.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = ref.watch(menuOpenedProvider);
    final todosAsyncValue = ref.watch(getTodosProvider);

    void displayModal() {
      showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: AddTodo(),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF1F0F6),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            const Positioned(
              left: 0,
              top: 0,
              child: TodoSideMenu(),
            ),
            AnimatedPositioned(
              width: isOpen ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width,
              height: isOpen ? MediaQuery.of(context).size.height * 0.85 : MediaQuery.of(context).size.height,
              top: isOpen ? 50.0 : 0,
              right: isOpen ? -260 : 0,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  bottomLeft: Radius.circular(60),
                ),
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: const Color(0xffF1F0F6).withOpacity(0.5),
                    leading: IconButton(
                      onPressed: () {
                        ref.read(menuOpenedProvider.notifier).state = !ref.read(menuOpenedProvider);
                      },
                      icon: const Icon(Icons.menu, color: Color(0xff9D9AB4)),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(
                                  todosAsyncValue.asData!.value.docs.map((e) => Todo.fromJson(e.data() as Map<String, dynamic>)).toList()));
                        },
                        icon: const Icon(Icons.search_rounded, color: Color(0xff9D9AB4)),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none, color: Color(0xff9D9AB4)),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: const Color(0xffF4F6FD),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const TodosHeader(),
                          const SizedBox(height: 40),
                          Text(
                            "TODAY'S TASKS",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          const HomeTodosListView(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: isOpen
          ? const SizedBox.shrink()
          : FloatingActionButton(
              onPressed: displayModal,
              tooltip: 'Add new todo',
              child: const Icon(Icons.add),
            ),
    );
  }
}

class HomeTodosListView extends ConsumerWidget {
  const HomeTodosListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsyncValue = ref.watch(getTodosProvider);

    return todosAsyncValue.when(
      data: (data) {
        final docs = data.docs;
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
