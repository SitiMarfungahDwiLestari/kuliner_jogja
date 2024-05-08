import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FooterWidget extends StatelessWidget {
  FooterWidget(
      {super.key,
      required this.onPressedLogin,
      required this.onPressedRegister});

  final VoidCallback onPressedLogin;
  final VoidCallback onPressedRegister;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        ElevatedButton(onPressed: onPressedLogin, child: Text("Login")),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Apakah Belum Punya Akun?"),
            TextButton(
                onPressed: onPressedRegister, child: const Text("Register"))
          ],
        )
      ],
    );
  }
}
