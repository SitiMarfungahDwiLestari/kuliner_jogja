import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Kuliner"),
      ),
      body: Center(
        child: Text("Form untuk menambahkan kuliner."),
      ),
    );
  }
}
