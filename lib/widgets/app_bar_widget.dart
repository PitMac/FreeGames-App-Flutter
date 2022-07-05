import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final String text;
  const AppBarWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.black,
    );
  }
}
