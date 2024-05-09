import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kuliner_jogja/model/kuliner.dart';

class KulinerService {
  // Base URL untuk backend API
  final String baseUrl = 'http://192.168.1.3/kuliner_jogja';
  
  Future<List<Kuliner>> getKuliners() async {
    final response = await http.get(Uri.parse('$baseUrl/read_kuliner.php'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Kuliner.fromMap(item)).toList();
    } else {
      throw Exception('Gagal mengambil data kuliner');
    }
  }
}
