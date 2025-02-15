import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFD9D9D9) // 타원 색상
      ..style = PaintingStyle.fill; // 채우기

    // 타원 그리기 (왼쪽, 위쪽, 너비, 높이 지정)
    canvas.drawOval(Rect.fromLTWH(29.w, 151.h, 334.w, 70.h), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // 다시 그릴 필요가 없으면 false 반환
  }
}
