import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todo_textfield.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleEdittingController = TextEditingController();
    final subtitleEdittingController = TextEditingController();
    final aboutEdittingController = TextEditingController();

    void addTodo() {
      final title = titleEdittingController.text.trim();
      final subtitle = subtitleEdittingController.text.trim();
      final about = aboutEdittingController.text.trim();

      final todo = Todo(title: title, subtitle: subtitle, about: about);
      ref.read(todoCloudFirestoreRepositoryProvider).add(todo);
    }

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add a new todo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TodoTextField(
              controller: titleEdittingController,
              label: 'Title',
            ),
            const SizedBox(height: 16),
            TodoTextField(
              controller: subtitleEdittingController,
              label: 'Sub-Title',
            ),
            const SizedBox(height: 16),
            TodoTextField(
              controller: aboutEdittingController,
              hintText: 'About',
              minLines: 5,
              maxLines: 15,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: addTodo,
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
