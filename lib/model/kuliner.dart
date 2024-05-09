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
      name: map['name'],
      location: map['location'],
      minPrice: map['minPrice'],
      maxPrice: map['maxPrice'],
      dishType: map['dishType'],
      image: map['image'] as File?,
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
