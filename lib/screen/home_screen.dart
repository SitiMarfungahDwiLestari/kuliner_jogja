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
        foodItems.add(newItem);
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
            color: Colors.yellow,
            elevation: 4.0,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: item['image'] != null
                  ? Image.file(item['image'], height: 40, width: 40, fit: BoxFit.cover)
                  : Icon(Icons.fastfood),
              title: Text(item['name']),
              subtitle: Text("Lokasi: ${item['location']}"), // Tampilkan lokasi
              trailing: Text(item['priceRange'] ?? ''),
              onTap: () => _editFoodItem(index),
            ),
          );
        },
      );
    }
  }

  void _editFoodItem(int index) async {
    final editedItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(foodItem: foodItems[index])),
    );

    if (editedItem == null) {
      setState(() {
        foodItems.removeAt(index); // Menghapus item jika sinyal penghapusan diterima
      });
    } else {
      setState(() {
        foodItems[index] = editedItem; // Perbarui item jika ada perubahan
      });
    }
  }
}
