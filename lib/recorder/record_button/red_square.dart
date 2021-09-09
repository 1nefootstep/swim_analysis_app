import 'package:flutter/material.dart';

class RedSquare extends StatelessWidget {
  final double size;
  const RedSquare({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      height: size,
      width: size,
    );
  }
}
