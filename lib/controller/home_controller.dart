import 'package:flutter/material.dart';
import 'package:kuliner_jogja/model/kuliner.dart';

class HomeController {
  List<Kuliner> foodItems = [];

  Future<void> addItem(BuildContext context, Widget createScreen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => createScreen),
    );

    if (result != null) {
      foodItems.add(Kuliner.fromMap(result));
    }
  }

  Future<void> editItem(
      BuildContext context, int index, Widget editScreen) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => editScreen),
    );

    if (result == null) {
      foodItems.removeAt(index); // Item dihapus
    } else {
      foodItems[index] = Kuliner.fromMap(result); // Item diperbarui
    }
  }
}
