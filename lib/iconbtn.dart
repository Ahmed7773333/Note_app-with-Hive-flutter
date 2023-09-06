import 'package:flutter/material.dart';

class Iconbtn extends StatelessWidget {
  Icon icon;
  double size;
  Iconbtn({required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xff3B3B3B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: icon,
    );
  }
}
