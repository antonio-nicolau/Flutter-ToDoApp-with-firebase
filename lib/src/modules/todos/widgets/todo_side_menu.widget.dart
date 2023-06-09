import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/repositories/cloud_firestore.repository.dart';
import 'package:flutter_cloud_firestore/src/core/router/app.route.dart';
import 'package:flutter_cloud_firestore/src/modules/auth/repositories/auth.repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final sideMenuOpenedProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class TodoSideMenu extends ConsumerWidget {
  const TodoSideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(getUserProfileProvider);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 90, left: 40),
      color: const Color(0xff2643C4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: SizedBox(
              width: 90,
              height: 90,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/flutter-firebase-and-riverpod.appspot.com/o/1651484443642.jpeg?alt=media&token=af7ed623-35c0-4ea7-8276-16730006dcbf',
              ),
            ),
          ),
          const SizedBox(height: 24),
          userAsyncValue.when(
            data: (user) {
              return Text(
                "${user.name}",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) {
              return Text('Error: $error');
            },
          ),
          const SizedBox(height: 30),
          MyListTile(
            icon: Icons.book,
            title: AppLocalizations.of(context)!.menu_templates,
            onTap: () {},
          ),
          MyListTile(
            icon: Icons.category_outlined,
            title: AppLocalizations.of(context)!.categories,
            onTap: () {},
          ),
          MyListTile(
            icon: Icons.analytics,
            title: AppLocalizations.of(context)!.menu_analytics,
            onTap: () {},
          ),
          MyListTile(
            icon: Icons.settings,
            title: AppLocalizations.of(context)!.menu_settings,
            onTap: () {},
          ),
          MyListTile(
            icon: Icons.logout_outlined,
            title: AppLocalizations.of(context)!.menu_logout,
            iconColor: Colors.red,
            titleColor: Colors.red,
            onTap: () {
              ref.read(authRepositoryProvider).logout();
              context.router.push(const HomeRoute());
              ref.invalidate(sideMenuOpenedProvider);
              ref.invalidate(cloudFirestoreRepositoryProvider);
              ref.invalidate(getUserProfileProvider);
              ref.invalidate(getTodosProvider);
              ref.invalidate(isAuthenticatedProvider);
            },
          ),
        ],
      ),
    );
  }
}

class MyListTile extends ConsumerWidget {
  final IconData? icon;
  final String? title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;

  const MyListTile({super.key, this.title, this.titleColor, this.icon, this.iconColor, this.onTap});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Icon(icon, size: 30, color: iconColor),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onTap,
            child: Text(
              "$title",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: titleColor),
            ),
          ),
        ],
      ),
    );
  }
}
