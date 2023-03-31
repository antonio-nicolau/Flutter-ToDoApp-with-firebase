import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/src/core/repositories/auth.repository.dart';
import 'package:flutter_cloud_firestore/firebase_options.dart';
import 'package:flutter_cloud_firestore/src/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final container = ProviderContainer();
  container.read(authStatusProvider);

  runApp(const ProviderScope(child: MyApp()));
}
