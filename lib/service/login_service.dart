import 'package:http/http.dart' as http;

class LoginService {
  // Base URL untuk backend API
  final String baseUrl = 'https://api.example.com/v1';  // Ganti dengan base URL yang sebenarnya
  
  // Endpoint untuk menambahkan pengguna
  final String endpoint = '/user/add';  // Endpoint untuk menambahkan pengguna
  
  // Fungsi untuk mendapatkan URI lengkap berdasarkan base URL dan endpoint
  Uri getUri() {
    return Uri.parse("$baseUrl$endpoint");
  }

  // Fungsi untuk menambahkan pengguna baru
  Future<http.Response> addUser(Map<String, String> data) async {
    var request = http.MultipartRequest('POST', getUri())
      ..fields.addAll(data)  // Menambahkan data pengguna
      ..headers['Content-Type'] = 'application/json';  // Set header untuk JSON

    // Kirim permintaan dan kembalikan respons
    return await http.Response.fromStream(await request.send());
  }
}
