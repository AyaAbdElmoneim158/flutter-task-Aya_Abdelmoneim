import 'package:flutter/material.dart';

class CustomArrowPainter extends CustomPainter {
  final Color color;
  final double notchPosition;

  const CustomArrowPainter({
    this.color = const Color(0xffFFDBDB),
    this.notchPosition = 9.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    path.moveTo(0, 6.1);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(notchPosition, size.height / 2);
    path.lineTo(0, 6.1);
    path.close();

    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is CustomArrowPainter && (oldDelegate.color != color || oldDelegate.notchPosition != notchPosition);
  }
}
