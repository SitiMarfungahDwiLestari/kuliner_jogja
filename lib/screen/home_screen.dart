import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:kuliner_jogja/widget/header_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Daftar Kuliner Jogja"),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const HeaderWidget(),
              ],
            ),
          ),
        ));
  }
}
