import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class GraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFFF1F1F1)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke; // 내부 색상을 채움

    // 오각형의 중심 좌표
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double distance = 105.w;

    for (int i = 0; i < 5; i++) {
      double angle = (pi / 2) + (2 * pi * i / 5); // 72도씩 회전 반시계 방향으로로
      double x = centerX + distance * cos(angle);
      double y = centerY - distance * sin(angle);
      canvas.drawLine(Offset(centerX, centerY), Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
