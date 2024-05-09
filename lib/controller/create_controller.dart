import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuliner_jogja/model/kuliner.dart';
import 'package:kuliner_jogja/screen/location_screen.dart';

class CreateController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  File? selectedImage;
  String? selectedLocation;
  String? selectedDishType;
  final List<String> dishTypes = [
    'Hidangan Pembuka',
    'Hidangan Utama',
    'Hidangan Pencuci Mulut',
    'Kopi',
    'Non Kopi',
    'Jus'
  ];
  String errorMessage = '';

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
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

  bool isValid() {
    return nameController.text.isNotEmpty &&
        minPriceController.text.isNotEmpty &&
        maxPriceController.text.isNotEmpty &&
        selectedLocation != null &&
        selectedDishType != null;
  }

  Kuliner createModel() {
    return Kuliner(
      name: nameController.text.trim(),
      location: selectedLocation!,
      minPrice: double.parse(minPriceController.text.trim()),
      maxPrice: double.parse(maxPriceController.text.trim()),
      dishType: selectedDishType!,
      image: selectedImage,
    );
  }

  void dispose() {
    nameController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
  }
}
