import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuliner_jogja/model/kuliner.dart';
import 'package:kuliner_jogja/screen/location_screen.dart';

class EditController {
  late TextEditingController nameController;
  late TextEditingController minPriceController;
  late TextEditingController maxPriceController;
  File? selectedImage;
  String? selectedLocation;
  late String selectedDishType;
  final List<String> dishTypes = [
    'Hidangan Pembuka',
    'Hidangan Utama',
    'Hidangan Pencuci Mulut',
    'Kopi',
    'Non Kopi',
    'Jus'
  ];

  EditController(Kuliner foodItem) {
    nameController = TextEditingController(text: foodItem.name);
    minPriceController = TextEditingController(
        text: foodItem.minPrice.toString()); // Mengonversi ke string
    maxPriceController =
        TextEditingController(text: foodItem.maxPrice.toString());
    selectedDishType = foodItem.dishType;
    selectedLocation = foodItem.location;
    if (foodItem.image != null) {
      selectedImage = foodItem.image;
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
    }
  }

  Future<void> selectLocation(BuildContext context) async {
    final result = await Navigator.push(
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

  bool isValid() {
    return nameController.text.isNotEmpty &&
        minPriceController.text.isNotEmpty &&
        maxPriceController.text.isNotEmpty &&
        selectedLocation != null &&
        selectedDishType.isNotEmpty;
  }

  Map<String, dynamic> getUpdatedData() {
    return {
      'name': nameController.text.trim(),
      'location': selectedLocation,
      'minPrice': double.parse(minPriceController.text.trim()),
      'maxPrice': double.parse(maxPriceController.text.trim()),
      'dishType': selectedDishType,
      'image': selectedImage,
    };
  }

  void dispose() {
    nameController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
  }
}
