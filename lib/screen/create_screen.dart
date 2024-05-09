import 'package:flutter/material.dart';
import 'package:kuliner_jogja/controller/create_controller.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final CreateController controller = CreateController();

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
              TextField(
                controller: controller.nameController,
                decoration: InputDecoration(
                  labelText: "Nama Kuliner",
                  hintText: "Masukkan nama kuliner",
                  errorText: controller.errorMessage.isNotEmpty
                      ? controller.errorMessage
                      : null,
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
                // Kisaran harga minimum dan maksimum
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: "Rp",
                        labelText: "Kisaran Harga Minimum",
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
                        labelText: "Kisaran Harga Maksimum",
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
                    controller.selectedDishType = value;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (controller.isValid()) {
                    final newItem = controller.submitData();
                    Navigator.pop(context, newItem);
                  } else {
                    setState(() {
                      controller.errorMessage = "Semua bidang harus diisi.";
                    });
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
    controller.dispose();
    super.dispose();
  }
}
