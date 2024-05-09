import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuliner_jogja/screen/location_screen.dart';
import 'dart:io';


class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController(); // Minimum harga
  final TextEditingController _maxPriceController = TextEditingController(); // Maksimum harga
  final List<String> dishTypes = [
    'Hidangan Pembuka',
    'Hidangan Utama',
    'Hidangan Pencuci Mulut',
    'Kopi',
    'Non Kopi',
    'Jus'
  ];
  String? _selectedDishType;
  File? _selectedImage;
  String? _selectedLocation;
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
                child: Text(_selectedLocation ?? "Pilih Lokasi"),
              ),
              SizedBox(height: 16),
              Row( 
                children: [
                  Expanded(
                    child: TextField(
                      controller: _minPriceController, // Harga minimum
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: "Rp", 
                        labelText: "Kisaran Harga Minimum",
                        hintText: "Masukkan harga minimum",
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Menambah jarak antara elemen
                  Text(
                    "--", // Simbol pemisah
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 16), // Jarak sebelum TextField berikutnya
                  Expanded(
                    child: TextField(
                      controller: _maxPriceController, // Harga maksimum
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: "Rp",
                        labelText: "Kisaran Harga Maksimum",
                        hintText: "Masukkan harga maksimum",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedDishType,
                hint: Text("Pilih Jenis Hidangan"),
                items: dishTypes
                    .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                    ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDishType = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onSubmit, // Menyimpan formulir
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
              _selectedLocation = location;
            });
          },
        ),
      ),
    );
  }

  void _onSubmit() {
    if (_nameController.text.isEmpty ||
        _minPriceController.text.isEmpty ||
        _maxPriceController.text.isEmpty ||
        _selectedLocation == null ||
        _selectedDishType == null) {
      setState(() {
        errorMessage = "Semua bidang harus diisi.";
      });
      return;
    }

    final newItem = {
      'name': _nameController.text.trim(),
      'location': _selectedLocation,
      'minPrice': double.parse(_minPriceController.text.trim()), // Harga minimum
      'maxPrice': double.parse(_maxPriceController.text.trim()), // Harga maksimum
      'dishType': _selectedDishType,
      'image': _selectedImage,
    };

    Navigator.pop(context, newItem); // Kirim data yang diperbarui ke layar sebelumnya
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }
}
