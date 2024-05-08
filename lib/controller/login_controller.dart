import 'dart:io';
import 'dart:convert';

import 'package:kuliner_jogja/model/user.dart';
import 'package:kuliner_jogja/service/login_service.dart';

class LoginController {
  final loginService = LoginService();

  Future<Map<String, dynamic>> addUser(Pengguna user) async {
    Map<String, String> data = {
      'nama': user.nama,
      'email': user.email,
    };

    try {
      var response = await loginService.addUser(data);

      if (response.statusCode == 201) {
        return {'succes': true, 'message': 'Data berhasil disimpan'};
      } else {
        //Penanganan ketika Content-Type bukan application/json
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'succes': false,
            'message': decodedJson['message'] ?? 'Terjadi kesalahan',
          };
        }
        var decodedJson = jsonDecode(response.body);
        return {
          'succes': false,
          'message':
              decodedJson['message'] ?? 'Terjadi kesalahan saat menyimpan data',
        };
      }
    } catch (e) {
      //Menangkap kesalahan jaringan atau saat decoding JSON
      return {
        'succes': false,
        'message': 'Terjadi kesalahan: $e',
      };
    }
  }
}
