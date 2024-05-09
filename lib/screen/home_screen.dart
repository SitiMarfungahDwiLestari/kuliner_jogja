import 'package:flutter/material.dart';
import 'create_screen.dart';
import 'edit_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> foodItems = []; // Daftar makanan

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
        foodItems.add(newItem as Map<String, dynamic>);
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
          final String priceRange =
              "Rp ${item['minPrice']} - Rp ${item['maxPrice']}"; // Kisaran harga
          return Card(
            color: Colors.yellow,
            elevation: 4.0,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: item['image'] != null
                  ? Image.file(item['image'],
                      height: 40, width: 40, fit: BoxFit.cover)
                  : Icon(Icons.fastfood),
              title: Text(item['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Lokasi: ${item['location']}"),
                  Text("Jenis: ${item['dishType']}"), // Jenis hidangan
                  Text("Harga: $priceRange"), // Kisaran harga
                ],
              ),
              trailing: Icon(Icons.edit), // Ikon untuk mengedit
              onTap: () => _editFoodItem(index), // Navigasi ke EditScreen
            ),
          );
        },
      );
    }
  }

  void _editFoodItem(int index) async {
    final item = foodItems[index];
    final updatedItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(foodItem: item)),
    );

    if (updatedItem == null) {
      // Jika item dihapus
      setState(() {
        foodItems.removeAt(index); // Hapus item dari daftar
      });
    } else {
      setState(() {
        foodItems[index] = updatedItem; // Perbarui data yang diedit
      });
    }
  }
}
