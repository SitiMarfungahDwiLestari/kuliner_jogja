import 'package:flutter/material.dart';
import 'package:kuliner_jogja/controller/home_controller.dart';
import 'package:kuliner_jogja/model/kuliner.dart';
import 'package:kuliner_jogja/screen/create_screen.dart';
import 'package:kuliner_jogja/screen/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  HomeScreen({Key? key, required this.email}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = HomeController(); // Inisialisasi controller
  bool dataFetched = false; // Menandakan apakah data sudah diambil

  @override
  void initState() {
    super.initState();
    fetchKuliner(); // Ambil data saat inisialisasi
  }

  Future<void> fetchKuliner() async {
    try {
      await controller.fetchKuliners(); // Ambil data kuliner dari controller
      setState(() {
        dataFetched = true; // Setelah data berhasil diambil
      });
    } catch (e) {
      setState(() {
        dataFetched = true; // Ubah status agar tidak terus loading
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengambil data kuliner: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Kuliner Jogja"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateScreen()),
          ).then((_) {
            fetchKuliner(); // Perbarui data setelah menambahkan item
          });
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: dataFetched
            ? _buildContent()
            : Center(
                child: CircularProgressIndicator()), // Tampilkan loading jika belum diambil
      ),
    );
  }

  Widget _buildContent() {
    if (controller.kulinerList.isEmpty) {
      return Center(
        child: Text(
          "Ketuk ikon + untuk menambahkan daftar kuliner",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: controller.kulinerList.length,
        itemBuilder: (context, index) {
          final item = controller.kulinerList[index];
          final priceRange = "Rp ${item.minPrice} - Rp ${item.maxPrice}";
          return Card(
            color: Colors.yellow,
            elevation: 4.0,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: item.image != null
                  ? Image.file(item.image!, height: 40, width: 40, fit: BoxFit.cover)
                  : Icon(Icons.fastfood),
              title: Text(item.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Lokasi: ${item.location}"),
                  Text("Jenis: ${item.dishType}"), // Menampilkan jenis hidangan
                  Text("Harga: $priceRange"), // Menampilkan kisaran harga
                ],
              ),
              trailing: Icon(Icons.edit), // Ikon untuk mengedit
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(foodItem: item.toMap()),
                  ),
                ).then((_) {
                  fetchKuliner(); // Perbarui data setelah diedit
                });
              },
            ),
          );
        },
      );
    }
  }
}
