import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Kuliner"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nama Kuliner",
                hintText: "Masukkan nama kuliner",
                errorText: errorMessage.isNotEmpty ? errorMessage : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onAddPressed,
              child: Text("Tambah"),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddPressed() {
    final String name = _nameController.text.trim();

    if (name.isEmpty) {
      setState(() {
        errorMessage = "Nama kuliner tidak boleh kosong";
      });
    } else {
      Navigator.pop(context, name); // Mengirim data kembali ke HomeScreen
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
