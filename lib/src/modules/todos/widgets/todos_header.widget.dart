import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todos_categories.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodosHeader extends ConsumerWidget {
  const TodosHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(getUserProfileProvider);

    return Column(
      children: [
        userAsyncValue.when(
          data: (user) {
            return Text(
              "What's up, ${user.name}",
              style: Theme.of(context).textTheme.headlineLarge,
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) {
            return Text('Error: $error');
          },
        ),
        const SizedBox(height: 40),
        const TodoCategories(),
      ],
    );
  }
}
