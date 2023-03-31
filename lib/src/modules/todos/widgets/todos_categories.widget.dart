import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/utils/theme_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categories = ['Business', 'Personal', 'Reading', 'Hang out'];

class TodoCategories extends ConsumerWidget {
  const TodoCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);

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
                    Text(
                      category,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: isDarkTheme ? const Color(0xff020417) : const Color(0xff020417),
                          ),
                    ),
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
