import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Iconbtn extends StatelessWidget {
  Icon icon;
  double size;
  Iconbtn({super.key, required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xff3B3B3B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: icon,
    );
  }
}
