import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 25,
        ),
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://th.bing.com/th/id/OIP.LVdrYD9VzTM8iOhN7bMCAQHaHa?w=850&h=850&rs=1&pid=ImgDetMain"),
          radius: 80,
        ),
      ],
    );
  }
}
