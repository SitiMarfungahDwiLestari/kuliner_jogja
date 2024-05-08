import 'package:flutter/material.dart';
import 'create_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> foodItems =
      []; // Daftar makanan, dengan informasi detail

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Kuliner Jogja"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreateScreen,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  void _goToCreateScreen() async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateScreen()),
    );

    if (newItem != null) {
      setState(() {
        foodItems.add(newItem
            as Map<String, dynamic>); // Tambahkan item baru ke daftar makanan
      });
    }
  }

  Widget _buildContent() {
    if (foodItems.isEmpty) {
      return Center(
        child: Text(
          "Ketuk ikon + untuk menambahkan daftar kuliner",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final item = foodItems[index];
          return Card(
            color: Colors.yellow, // Warna latar belakang
            elevation: 4.0, // Efek bayangan
            margin: EdgeInsets.symmetric(
                vertical: 8, horizontal: 16), // Margin antara item
            child: ListTile(
              leading: item['image'] != null // Menampilkan foto jika ada
                  ? Image.file(item['image'],
                      height: 40, width: 40, fit: BoxFit.cover)
                  : Icon(Icons.fastfood), // Ikon jika tidak ada foto
              title: Text(item['name']), // Nama kuliner
              subtitle: Text("Lokasi: ${item['location']}"), // Lokasi kuliner
              trailing: Text(item['priceRange'] ?? ''), // Kisaran harga
            ),
          );
        },
      );
    }
  }
}
