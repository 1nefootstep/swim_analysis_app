import 'package:flutter/material.dart';

class RedCircle extends StatelessWidget {
  final double size;
  const RedCircle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      height: size,
      width: size,
    );
  }
}
