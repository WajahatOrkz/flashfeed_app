import 'package:flutter/material.dart';

class ThreeLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final double spacing = size.width * 0.25;
    final double startY = size.height * 0.3;
    final double endY = size.height * 0.7;

    for (int i = 0; i < 3; i++) {
      final double x = spacing * (i + 1);
      canvas.drawLine(
        Offset(x, startY),
        Offset(x, endY),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}