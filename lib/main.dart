import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todos Firebase',
        home: Scaffold(
          appBar: AppBar(
              leading: Icon(Icons.ballot_rounded),
              title: const Text('Todos Firebase')),
        ));
  }
}

class MyAppState extends ChangeNotifier {}
