import 'package:flutter/material.dart';
import 'create_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> foodItems = []; // Daftar makanan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Kuliner Jogja"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToCreateScreen, // Metode untuk navigasi ke CreateScreen
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  void _goToCreateScreen() async {
    // Navigasi ke CreateScreen dan tunggu nilai yang dikembalikan
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateScreen()),
    );

    if (newItem != null) {
      // Jika nilai dikembalikan, tambahkan ke daftar
      setState(() {
        foodItems
            .add(newItem as String); // Tambahkan item baru ke daftar makanan
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
          return Card(
            color: Colors.yellow, // Latar belakang kuning
            elevation: 4.0, // Efek bayangan
            margin: EdgeInsets.symmetric(
                vertical: 8, horizontal: 16), // Margin antara item
            child: ListTile(
              title: Text(foodItems[index]),
            ),
          );
        },
      );
    }
  }
}
