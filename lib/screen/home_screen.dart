import 'package:flutter/material.dart';
import 'package:kuliner_jogja/controller/home_controller.dart';
import 'package:kuliner_jogja/screen/create_screen.dart';
import 'package:kuliner_jogja/screen/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Kuliner Jogja"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.addItem(context, CreateScreen());
          setState(() {}); // Perbarui tampilan setelah menambahkan item
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (controller.foodItems.isEmpty) {
      return Center(
        child: Text(
          "Ketuk ikon + untuk menambahkan daftar kuliner",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: controller.foodItems.length,
        itemBuilder: (context, index) {
          final item = controller.foodItems[index];
          final String priceRange =
              "Rp ${item.minPrice} - Rp ${item.maxPrice}"; // Kisaran harga
          return Card(
            color: Colors.yellow,
            elevation: 4.0,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: item.image != null
                  ? Image.file(item.image!,
                      height: 40, width: 40, fit: BoxFit.cover)
                  : Icon(Icons.fastfood),
              title: Text(item.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Lokasi: ${item.location}"),
                  Text("Jenis: ${item.dishType}"), // Jenis hidangan
                  Text("Harga: $priceRange"), // Kisaran harga
                ],
              ),
              trailing: Icon(Icons.edit), // Ikon untuk mengedit
              onTap: () async {
                await controller.editItem(
                    context, index, EditScreen(foodItem: item.toMap()));
                setState(
                    () {}); // Perbarui tampilan setelah mengedit atau menghapus
              },
            ),
          );
        },
      );
    }
  }
}
