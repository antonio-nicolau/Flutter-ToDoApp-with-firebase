import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/src/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/add_todo/pages/add_todo.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todo_search_delegate.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todo_side_menu.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todos_header.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todos_listview.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final isSideMenuOpened = ref.watch(sideMenuOpenedProvider);
    final todosAsyncValue = ref.watch(getTodosProvider);

    void displayModal() {
      showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: screenSize.height * 0.85,
            child: AddTodo(),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(
        width: screenSize.width,
        child: Stack(
          children: [
            const Positioned(
              left: 0,
              top: 0,
              child: TodoSideMenu(),
            ),
            AnimatedPositioned(
              width: isSideMenuOpened ? screenSize.width : screenSize.width,
              height: isSideMenuOpened ? screenSize.height * 0.85 : screenSize.height,
              top: isSideMenuOpened ? 50.0 : 0,
              right: isSideMenuOpened ? -260 : 0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.fastOutSlowIn,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(60),
                  bottomLeft: Radius.circular(60),
                ),
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Theme.of(context).primaryColor,
                    leading: IconButton(
                      onPressed: () {
                        ref.read(sideMenuOpenedProvider.notifier).state = !ref.read(sideMenuOpenedProvider);
                      },
                      icon: Icon(isSideMenuOpened ? Icons.close_rounded : Icons.menu),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(
                                  todosAsyncValue.asData!.value.docs.map((e) => Todo.fromJson(e.data() as Map<String, dynamic>)).toList()));
                        },
                        icon: const Icon(Icons.search_rounded),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const TodosHeader(),
                          const SizedBox(height: 40),
                          Text(
                            AppLocalizations.of(context)!.todos_listview_section_title.toUpperCase(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          const TodosListView(),
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
      floatingActionButton: isSideMenuOpened
          ? const SizedBox.shrink()
          : FloatingActionButton(
              onPressed: displayModal,
              tooltip: AppLocalizations.of(context)!.add_new_todo_floating_action_button,
              child: const Icon(Icons.add),
            ),
    );
  }
}
