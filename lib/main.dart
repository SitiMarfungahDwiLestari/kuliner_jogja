import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kuliner_jogja/controller/login_controller.dart';
import 'package:kuliner_jogja/model/user.dart';
import 'package:kuliner_jogja/screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuliner Jogja',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Kuliner Jogja")),
        ),
        body: LoginScreen(),
      ),
    );
  }
}
