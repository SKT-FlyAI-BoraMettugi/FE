import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final double radius;
  final Color color;
  final double centerX;
  final double centerY;

  CirclePainter({
    required this.radius,
    required this.color,
    required this.centerX,
    required this.centerY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color // 원의 색상
      ..style = PaintingStyle.fill; // 원을 채우기

    // 원 그리기 (중심 좌표와 반지름을 설정)
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // 다시 그릴 필요가 없으면 false 반환
  }
}
