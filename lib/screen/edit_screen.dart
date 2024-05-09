import 'package:flutter/material.dart';
import 'package:kuliner_jogja/controller/edit_controller.dart';

class EditScreen extends StatefulWidget {
  final Map<String, dynamic> foodItem;

  EditScreen({Key? key, required this.foodItem}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late EditController controller;

  @override
  void initState() {
    super.initState();
    controller = EditController(widget.foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Kuliner"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _onDeletePressed,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: "Nama Kuliner",
                  hintText: "Masukkan nama kuliner",
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  await controller.pickImage();
                  setState(() {}); // Perbarui tampilan setelah memilih gambar
                },
                child: controller.selectedImage != null
                    ? Image.file(controller.selectedImage!, height: 150)
                    : Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Center(
                          child: Text("Pilih Foto"),
                        ),
                      ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await controller.selectLocation(context);
                  setState(() {}); // Perbarui tampilan setelah memilih lokasi
                },
                child: Text(controller.selectedLocation ?? "Pilih Lokasi"),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: "Rp",
                        labelText: "Harga Minimum",
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "-",
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: controller.maxPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: "Rp",
                        labelText: "Harga Maksimum",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: controller.selectedDishType,
                hint: Text("Pilih Jenis Hidangan"),
                items: controller.dishTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    controller.selectedDishType = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (controller.isValid()) {
                    final updatedItem = controller.getUpdatedData();
                    Navigator.pop(context, updatedItem);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Pastikan semua bidang diisi"),
                      ),
                    );
                  }
                },
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onDeletePressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Konfirmasi Penghapusan"),
        content: Text("Anda yakin ingin menghapus data ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              Navigator.pop(context, null); // Kirim sinyal penghapusan
            },
            child: Text("Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
