import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kuliner_jogja/screen/location_screen.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<String> priceRanges = ['Murah', 'Sedang', 'Mahal'];
  String? _selectedPriceRange;
  File? _selectedImage;
  String? _selectedLocation; // Lokasi yang dipilih
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Kuliner"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: _selectedImage != null
                    ? Image.file(_selectedImage!, height: 150)
                    : Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text("Pilih Foto"),
                        ),
                      ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selectLocation,
                child: Text(_selectedLocation != null
                    ? "Lokasi: $_selectedLocation"
                    : "Pilih Lokasi"),
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedPriceRange,
                hint: Text("Pilih Kisaran Harga"),
                items: priceRanges
                    .map((range) => DropdownMenuItem(
                          value: range,
                          child: Text(range),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriceRange = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onSubmit,
                child: Text("Tambah"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _selectLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          onLocationSelected: (String location) {
            setState(() {
              _selectedLocation = location; // Simpan lokasi yang dipilih
            });
          },
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_nameController.text.isEmpty ||
        _selectedLocation == null ||
        _selectedPriceRange == null) {
      setState(() {
        errorMessage = "Semua bidang harus diisi.";
      });
      return;
    }

    final newItem = {
      'name': _nameController.text.trim(),
      'location': _selectedLocation,
      'priceRange': _selectedPriceRange,
      'image': _selectedImage,
    };

    Navigator.pop(context, newItem); // Kirim data kembali ke HomeScreen
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
