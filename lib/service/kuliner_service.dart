import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:kuliner_jogja/model/kuliner.dart';

class KulinerService {
  // Base URL untuk backend API
  final String baseUrl = 'http://192.168.1.9/kuliner_jogja';

  Future<List<Kuliner>> getKuliners() async {
    final response = await http.get(Uri.parse('$baseUrl/read_kuliner.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Kuliner.fromMap(item)).toList();
    } else {
      throw Exception('Gagal mengambil data kuliner');
    }
  }

  // Fungsi untuk membuat kuliner baru di server
  Future<bool> createKuliner(Kuliner kuliner) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create_kuliner.php'), // Endpoint untuk menambah kuliner
      body: {
        'name': kuliner.name,
        'location': kuliner.location,
        'minPrice': kuliner.minPrice.toString(),
        'maxPrice': kuliner.maxPrice.toString(),
        'dishType': kuliner.dishType,
        'image': kuliner.image?.path ?? '', // Pastikan gambar benar
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result['pesan'] == 'Sukses'; // Mengembalikan true jika sukses
    } else {
      throw Exception('Gagal membuat kuliner');
    }
  }
}
