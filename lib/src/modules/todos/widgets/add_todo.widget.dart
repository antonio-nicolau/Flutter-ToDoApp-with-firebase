import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/core/models/todo.model.dart';
import 'package:flutter_cloud_firestore/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todo_date_picker.widget.dart';
import 'package:flutter_cloud_firestore/src/modules/todos/widgets/todo_textfield.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleEdittingController = TextEditingController();
    final dateEdittingController = TextEditingController();

    void addTodo() {
      final title = titleEdittingController.text.trim();

      final todo = Todo(title: title);
      ref.read(todoCloudFirestoreRepositoryProvider).add(todo);
      Navigator.pop(context);
    }

    void openCalendar(BuildContext context, TextEditingController controller) {
      final dateFormat = DateFormat('yyyy-MM-dd');
      TodoDatePicker(
        context: context,
        controller: controller,
        firstDate: DateTime.now(),
        dateFormat: dateFormat,
        onChanged: (date) {
          controller.text = dateFormat.format(date);
        },
      ).show();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: const Color(0xff9D9AB4)),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  margin: const EdgeInsets.only(right: 20, top: 32),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_sharp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TodoTextField(
                      controller: titleEdittingController,
                      label: 'Enter new task',
                      minLines: 5,
                      maxLines: 15,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => openCalendar(context, dateEdittingController),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xffF4F6FD)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: const BorderSide(color: Color(0xff9D9AB4)),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.calendar_today_outlined, color: Color(0xff9D9AB4)),
                            const SizedBox(width: 10),
                            Text(
                              dateEdittingController.text.isEmpty ? 'Today' : dateEdittingController.text,
                              style: const TextStyle(color: Color(0xff9D9AB4), fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addTodo,
        label: const Text('New task'),
        icon: const Icon(Icons.keyboard_arrow_up_rounded),
      ),
    );
  }
}
