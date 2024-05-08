
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  FormWidget(
      {super.key,
      required this.formKey,
      required this.etEmail,
      required this.etPassword});
  final GlobalKey<FormState> formKey;
  final TextEditingController etEmail;
  final TextEditingController etPassword;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          children: [
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: widget.etEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Masukkan Email",
                    prefixIcon: Icon(Icons.email)),
                validator: (value) {
                  bool valid = RegExp(r"@").hasMatch(value!);
                  if (value.isEmpty) {
                    return "Masukkan email dengan benar";
                  } else if (!valid) {
                    return "Harus ada @";
                  }
                  return null;
                }),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: widget.etPassword,
              decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Masukkan Password",
                  prefixIcon: Icon(Icons.lock)),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Masukkan password dengan benar";
                } else if (value.length < 6) {
                  return "Masukkan minimal 6 karakter";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ));
  }
}
