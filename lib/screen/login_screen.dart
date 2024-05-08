import 'package:flutter/material.dart';
import 'package:kuliner_jogja/screen/home_screen.dart';
import 'package:kuliner_jogja/widget/footer_widget.dart';
import 'package:kuliner_jogja/widget/form_widget.dart';
import 'package:kuliner_jogja/widget/header_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Center(
        child: Column(children: [
          const HeaderWidget(),
          FormWidget(
            etEmail: email,
            etPassword: password,
            formKey: formKey,
          ),
          FooterWidget(
            onPressedLogin: () {
              if (formKey.currentState!.validate()) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(email: email.text)),
                    (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Login Berhasil"),
                ));
              }
            },
            onPressedRegister: () {},
          )
        ]),
      )),
    );
  }
}
