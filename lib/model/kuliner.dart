import 'dart:io';

class Kuliner {
  String name;
  String location;
  double minPrice;
  double maxPrice;
  String dishType;
  File? image;

  Kuliner({
    required this.name,
    required this.location,
    required this.minPrice,
    required this.maxPrice,
    required this.dishType,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'dishType': dishType,
      'image': image,
    };
  }

  static Kuliner fromMap(Map<String, dynamic> map) {
    return Kuliner(
      name: map['name'] ?? '', // Berikan default jika null
      location: map['location'] ?? '', // Berikan default jika null
      minPrice: map['minPrice'] != null ? double.parse(map['minPrice'].toString()) : 0.0, // Tangani null
      maxPrice: map['maxPrice'] != null ? double.parse(map['maxPrice'].toString()) : 0.0, // Tangani null
      dishType: map['dishType'] ?? '', // Berikan default jika null
      image: map['image'] != null ? File(map['image']) : null, // Tangani null
    );
  }

  bool isValid() {
    return name.isNotEmpty &&
        location.isNotEmpty &&
        minPrice >= 0 &&
        maxPrice >= 0 &&
        minPrice <= maxPrice &&
        dishType.isNotEmpty;
  }
}
