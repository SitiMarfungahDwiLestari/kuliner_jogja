import 'dart:convert';

class Pengguna {
  final String nama;
  final String email;
  Pengguna({
    required this.nama,
    required this.email,
  });
  Pengguna copyWith({
    String? nama,
    String? email,
  }) {
    return Pengguna(
      nama: nama ?? this.nama,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'email': email,
    };
  }

  factory Pengguna.fromMap(Map<String, dynamic> map) {
    return Pengguna(
      nama: map['nama'] as String,
      email: map['email'] as String,
    );
  }
  String toJson() => json.encode(toMap());

  factory Pengguna.fromJson(String source) =>
      Pengguna.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pengguna(nama: $nama, email: $email)';
  }

  @override
  bool operator ==(covariant Pengguna other) {
    if (identical(this, other)) return true;
    return other.nama == nama && other.email == email;
  }
  
  @override
  int get hashCode {
    return nama.hashCode ^
        email.hashCode;
  }
}
