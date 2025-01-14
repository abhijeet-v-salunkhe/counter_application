import 'package:couter_application/authentication/view/login.dart';
import 'package:couter_application/counter_screen.dart';
import 'package:couter_application/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("Firebase initialized.");
  } catch (e) {
    print(" $e Firebase is not Initialized");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Counter App', home: Wrapper());
  }
}
