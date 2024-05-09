import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:kuliner_jogja/screen/location_screen.dart';

class EditScreen extends StatefulWidget {
  final Map<String, dynamic> foodItem; // Data kuliner yang akan diedit

  EditScreen({Key? key, required this.foodItem}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _minPriceController;
  late TextEditingController _maxPriceController;
  late String _selectedDishType;
  File? _selectedImage;
  String? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.foodItem['name']); // Mengisi data awal
    _locationController =
        TextEditingController(text: widget.foodItem['location']);
    _minPriceController = TextEditingController(
        text: widget.foodItem['minPrice'].toString()); // Mengonversi ke string
    _maxPriceController =
        TextEditingController(text: widget.foodItem['maxPrice'].toString());
    _selectedDishType = widget.foodItem['dishType'] ?? '';
    _selectedLocation = widget.foodItem['location'];
    if (widget.foodItem['image'] != null) {
      _selectedImage = widget.foodItem['image'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Kuliner"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete), // Tombol hapus
            onPressed: _onDeletePressed, // Fungsi untuk menghapus data
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Nama Kuliner",
                  hintText: "Masukkan nama kuliner",
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage, // Memilih gambar
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
                onPressed: _selectLocation, // Memilih lokasi
                child: Text(_selectedLocation ?? "Pilih Lokasi"),
              ),
              SizedBox(height: 16),
              Row(
                // Kisaran harga minimum dan maksimum
                children: [
                  Expanded(
                    child: TextField(
                      controller: _minPriceController, // Harga minimum
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: "Rp", // Label "Rp"
                        labelText: "Harga Minimum",
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Jarak antara elemen
                  Text(
                    "-", // Simbol pemisah
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _maxPriceController, // Harga maksimum
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: "Rp",
                        labelText: "Harga Maksimum",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedDishType,
                hint: Text("Pilih Jenis Hidangan"),
                items: [
                  'Hidangan Pembuka',
                  'Hidangan Utama',
                  'Hidangan Pencuci Mulut',
                  'Kopi',
                  'Non Kopi',
                  'Jus'
                ]
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDishType = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _onSave,
                child: Text("Simpan"),
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

  void _onSave() {
    final updatedItem = {
      'name': _nameController.text.trim(),
      'location': _selectedLocation,
      'minPrice': double.parse(_minPriceController.text.trim()),
      'maxPrice': double.parse(_maxPriceController.text.trim()),
      'dishType': _selectedDishType,
      'image': _selectedImage,
    };

    Navigator.pop(context, updatedItem);
  }

  void _onDeletePressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi Penghapusan"),
        content: Text("Anda yakin ingin menghapus data ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, null);
            },
            child: Text("Hapus"),
          ),
        ],
      ),
    );
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
