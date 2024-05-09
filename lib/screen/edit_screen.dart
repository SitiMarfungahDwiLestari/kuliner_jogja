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
  late String _selectedPriceRange;
  File? _selectedImage; // Menyimpan gambar yang dipilih
  String? _selectedLocation; // Menyimpan lokasi yang dipilih

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.foodItem['name']);
    _locationController =
        TextEditingController(text: widget.foodItem['location']);
    _selectedPriceRange = widget.foodItem['priceRange'] ?? '';
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
                onTap: _pickImage, // Memilih gambar saat diketuk
                child: _selectedImage != null
                    ? Image.file(_selectedImage!,
                        height: 150) // Menampilkan gambar yang dipilih
                    : Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  Colors.grey), // Bingkai jika tidak ada gambar
                        ),
                        child: Center(
                          child: Text("Pilih Foto"),
                        ),
                      ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _selectLocation,
                child: Text(_selectedLocation ??
                    "Pilih Lokasi"), // Menampilkan lokasi yang dipilih
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
                onPressed: _onSave, // Simpan perubahan
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
        _selectedImage = File(pickedFile.path); // Simpan gambar yang dipilih
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

  void _onSave() {
    final updatedItem = {
      'name': _nameController.text.trim(),
      'location': _selectedLocation,
      'priceRange': _selectedPriceRange,
      'image': _selectedImage,
    };

    Navigator.pop(
        context, updatedItem); // Kirim data yang diperbarui ke layar sebelumnya
  }

  void _onDeletePressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi Penghapusan"),
        content: Text("Anda yakin ingin menghapus data ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Batal
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              Navigator.pop(context,
                  null); // Kirim sinyal penghapusan ke layar sebelumnya
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
    super.dispose();
  }
}
