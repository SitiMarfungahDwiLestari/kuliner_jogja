import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditScreen extends StatefulWidget {
  final Map<String, dynamic> foodItem; // Data kuliner yang akan diedit

  EditScreen({Key? key, required this.foodItem}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late String _selectedPriceRange;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.foodItem['name']);
    _locationController = TextEditingController(text: widget.foodItem['location']);
    _selectedPriceRange = widget.foodItem['priceRange'] ?? '';
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
            icon: Icon(Icons.delete), // Ikon hapus
            onPressed: _onDeletePressed, // Fungsi untuk menghapus data
          ),
        ],
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
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: "Lokasi",
                  hintText: "Masukkan lokasi",
                ),
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedPriceRange,
                hint: Text("Pilih Kisaran Harga"),
                items: ['Murah', 'Sedang', 'Mahal']
                    .map((range) => DropdownMenuItem(
                        value: range,
                        child: Text(range),
                    ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriceRange = value!;
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

  void _onSave() {
    final updatedItem = {
      'name': _nameController.text.trim(),
      'location': _locationController.text.trim(),
      'priceRange': _selectedPriceRange,
      'image': _selectedImage,
    };

    Navigator.pop(context, updatedItem); // Kirim data kembali ke HomeScreen
  }

  void _onDeletePressed() {
    // Mengirim sinyal bahwa data harus dihapus
    Navigator.pop(context, null); // Kirimkan null untuk menandakan penghapusan
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
