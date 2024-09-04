import 'dart:async';

import 'package:flutter/material.dart';
import 'package:student_db/db/functions/functions.dart';
import 'package:student_db/sreens/splash.dart';


Future<void> main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await initializeDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sqflite',
      home: Splash(),
     
    );
  }
}
