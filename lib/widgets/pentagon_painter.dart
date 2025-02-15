import 'package:flutter/material.dart';
import 'dart:math';

class PentagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFFF1F1F1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke; // 내부 색상을 채움

    final Path path = Path();

    // 오각형의 중심 좌표
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = min(size.width, size.height) / 2; // 반지름 설정

    for (int i = 0; i < 5; i++) {
      double angle = (pi / 2) + (2 * pi * i / 5); // 72도씩 회전
      double x = centerX + radius * cos(angle);
      double y = centerY - radius * sin(angle); // y 좌표는 위로 증가해야 하므로 -sin 사용

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close(); // 마지막 점과 첫 번째 점을 연결

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
