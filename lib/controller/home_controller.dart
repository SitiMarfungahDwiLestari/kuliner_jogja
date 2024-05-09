import 'package:flutter/material.dart';
import 'package:kuliner_jogja/service/kuliner_service.dart';
import 'package:kuliner_jogja/model/kuliner.dart';

class HomeController extends ChangeNotifier {
  final KulinerService kulinerService = KulinerService(); // Inisialisasi service
  List<Kuliner> kulinerList = []; // Daftar kuliner yang diambil dari server

  // Mengambil data kuliner dari backend
  Future<void> fetchKuliners() async {
    try {
      kulinerList = await kulinerService.getKuliners(); // Ambil data
      notifyListeners(); // Beritahu UI bahwa data telah berubah
    } catch (e) {
      throw Exception("Gagal mengambil data kuliner: $e");
    }
  }
}
