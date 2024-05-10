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
  final HomeController controller = HomeController(); // Inisialisasi controller
  bool isLoading = true; // Status loading

  @override
  void initState() {
    super.initState();
    fetchKuliner(); // Ambil data saat inisialisasi
  }

  Future<void> fetchKuliner() async {
    try {
      await controller.fetchKuliners(); // Ambil data dari controller
      setState(() {
        isLoading = false; // Setelah data diambil, matikan loading
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Selalu matikan loading
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
          ).then((_) => fetchKuliner()); // Ambil ulang data setelah kembali
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Tampilkan loading
            : _buildContent(), // Tampilkan konten setelah data diambil
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
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.fastfood),
              title: Text(item.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Lokasi: ${item.location}"),
                  Text("Jenis: ${item.dishType}"),
                  Text("Harga: Rp${item.minPrice} - Rp${item.maxPrice}"),
                ],
              ),
              trailing: Icon(Icons.edit), // Ikon untuk mengedit
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(
                      foodItem: item.toMap(),
                    ),
                  ),
                ).then((_) => fetchKuliner()); // Ambil ulang setelah diedit
              },
            ),
          );
        },
      );
    }
  }
}
