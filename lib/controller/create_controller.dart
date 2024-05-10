import 'dart:io';
import 'package:flutter/material.dart';
import 'package:kuliner_jogja/model/kuliner.dart';
import 'package:kuliner_jogja/screen/location_screen.dart';
import 'package:kuliner_jogja/service/kuliner_service.dart';
import 'package:image_picker/image_picker.dart'; // Untuk memilih gambar

class CreateController extends ChangeNotifier {
  final KulinerService kulinerService =
      KulinerService(); // Service yang sudah dibuat
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  File? selectedImage; // Untuk menyimpan gambar yang dipilih
  String? selectedLocation;
  String? selectedDishType; // Untuk jenis hidangan yang dipilih

  // Fungsi untuk memilih gambar
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path); // Simpan gambar yang dipilih
      notifyListeners(); // Update UI
    }
  }

  Future<void> selectLocation(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          onLocationSelected: (String location) {
            selectedLocation = location;
          },
        ),
      ),
    );
  }

  // Fungsi untuk membuat kuliner baru
  Future<void> createKuliner() async {
    if (isValid()) {
      // Periksa validitas input
      Kuliner newKuliner = Kuliner(
        name: nameController.text.trim(),
        location: selectedLocation ?? '',
        minPrice: double.parse(minPriceController.text.trim()),
        maxPrice: double.parse(maxPriceController.text.trim()),
        dishType: selectedDishType ?? '', // Pastikan nilai tidak kosong
        image: selectedImage, // Gambar yang dipilih
      );

      try {
        final isSuccess =
            await kulinerService.createKuliner(newKuliner); // Panggil service
        if (!isSuccess) {
          throw Exception('Gagal membuat kuliner');
        }
        notifyListeners(); // Beritahu UI jika operasi berhasil
      } catch (e) {
        throw Exception('Gagal membuat kuliner: $e');
      }
    } else {
      throw Exception('Data input tidak valid');
    }
  }

  // Validasi untuk memastikan input lengkap
  bool isValid() {
    return nameController.text.isNotEmpty &&
        minPriceController.text.isNotEmpty &&
        maxPriceController.text.isNotEmpty &&
        selectedLocation != null &&
        selectedDishType != null;
  }

  @override
  void dispose() {
    // Bersihkan controller saat tidak lagi digunakan
    nameController.dispose();
    locationController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }
}
