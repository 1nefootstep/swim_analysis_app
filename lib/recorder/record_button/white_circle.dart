import 'package:flutter/material.dart';

class WhiteCircle extends StatelessWidget {
  final double size;
  const WhiteCircle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      height: size,
      width: size,
    );
  }
}
