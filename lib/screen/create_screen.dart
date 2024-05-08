import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final List<String> priceRanges = [
    'Murah',
    'Sedang',
    'Mahal'
  ]; // Opsi kisaran harga
  String? _selectedPriceRange;
  File? _selectedImage; // Menyimpan gambar yang dipilih
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
          // Agar layar dapat digulir jika konten panjang
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
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery); // Pilih gambar dari galeri
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _onSubmit() {
    final String name = _nameController.text.trim();
    final String location = _locationController.text.trim();

    if (name.isEmpty || location.isEmpty || _selectedPriceRange == null) {
      setState(() {
        errorMessage = "Semua bidang harus diisi.";
      });
      return;
    }

    // Kirim data kembali ke layar sebelumnya
    final Map<String, dynamic> kuliner = {
      'name': name,
      'image': _selectedImage, // Mengembalikan foto yang dipilih
      'location': location,
      'priceRange': _selectedPriceRange,
    };

    Navigator.pop(context, kuliner);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
