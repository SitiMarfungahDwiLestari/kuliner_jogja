import 'package:flutter/material.dart';
import 'package:kuliner_jogja/widget/header_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, required this.email});

  final String email;

  // Simulasi daftar makanan, untuk sementara kita kosongkan
  final List<String> foodItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Kuliner Jogja"),
      ),
      // Menambahkan FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Logika untuk menambahkan item ke daftar (nanti diimplementasikan)
          // Biasanya, kita bisa memanggil layar baru untuk menambahkan item baru
          print("FAB ditekan");
        },
        child: Icon(Icons.add), // Ikon tanda +
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child:
                    _buildContent(), // Memanggil metode untuk menampilkan konten
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    // Jika daftar kosong, tampilkan pesan
    if (foodItems.isEmpty) {
      return Center(
        child: Text(
          "Ketuk ikon + untuk menambahkan daftar kuliner",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    } else {
      // Jika daftar tidak kosong, tampilkan item
      return ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foodItems[index]), // Tampilkan nama makanan
          );
        },
      );
    }
  }
}