import 'package:flutter/material.dart';

class HomeController {
  List<Map<String, dynamic>> foodItems = [];

  Future<void> addItem(BuildContext context, Widget createScreen) async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => createScreen),
    );

    if (newItem != null) {
      foodItems.add(newItem as Map<String, dynamic>);
    }
  }

  Future<void> editItem(
      BuildContext context, int index, Widget editScreen) async {
    final item = foodItems[index];
    final updatedItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => editScreen),
    );

    if (updatedItem == null) {
      foodItems.removeAt(index); // Item dihapus
    } else {
      foodItems[index] = updatedItem; // Item diperbarui
    }
  }
}
