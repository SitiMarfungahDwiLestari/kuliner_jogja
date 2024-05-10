import 'package:flutter/material.dart';
import 'package:kuliner_jogja/controller/create_controller.dart';
import 'package:kuliner_jogja/model/kuliner.dart';
import 'package:image_picker/image_picker.dart'; // Untuk memilih gambar

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final CreateController controller =
      CreateController(); // Controller yang sudah dibuat

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Kuliner"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input untuk nama kuliner
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: "Nama Kuliner",
                  hintText: "Masukkan nama kuliner",
                ),
              ),
              SizedBox(height: 16),
              // Tombol untuk memilih gambar
              GestureDetector(
                onTap: () async {
                  await controller
                      .pickImage(); // Panggil fungsi untuk memilih gambar
                  setState(() {}); // Perbarui tampilan
                },
                child: controller.selectedImage != null
                    ? Image.file(controller.selectedImage!,
                        height: 150) // Tampilkan gambar
                    : Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text("Pilih Gambar"),
                        ),
                      ),
              ),
              SizedBox(height: 16),
              // Input untuk lokasi
              ElevatedButton(
                onPressed: () async {
                  await controller
                      .selectLocation(context); // Buka pemilih lokasi
                  setState(() {}); // Perbarui tampilan setelah memilih lokasi
                },
                child: Text(controller.selectedLocation ??
                    "Pilih Lokasi"), // Tampilkan teks yang benar
              ),

              SizedBox(height: 16),
              // Input untuk kisaran harga
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Harga Minimum",
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text("-"),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: controller.maxPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Harga Maximum",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Dropdown untuk jenis hidangan
              DropdownButton<String>(
                hint: Text("Pilih Jenis Hidangan"),
                value: controller.selectedDishType,
                items: [
                  'Hidangan Pembuka',
                  'Hidangan Utama',
                  'Hidangan Pencuci Mulut',
                  'Kopi',
                  'Non Kopi',
                  'Jus',
                ]
                    .map((item) => DropdownMenuItem(
                          child: Text(item),
                          value: item,
                        ))
                    .toList(),
                onChanged: (value) {
                  controller.selectedDishType = value;
                  setState(() {}); // Perbarui tampilan saat jenis berubah
                },
              ),
              SizedBox(height: 16),
              // Tombol untuk submit data
              ElevatedButton(
                onPressed: () async {
                  try {
                    await controller
                        .createKuliner(); // Panggil controller untuk menambah data
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Kuliner berhasil ditambahkan")),
                    );
                    Navigator.pop(context); // Kembali ke screen sebelumnya
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Gagal menambahkan kuliner")),
                    );
                  }
                },
                child: Text("Tambah"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose(); // Bersihkan controller saat screen ditutup
    super.dispose();
  }
}
