import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.purple.shade200
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    // 원을 그려서 구름을 만듦
    canvas.drawCircle(
      Offset(130.w, 250.h),
      100.r,
      paint,
    );
    canvas.drawCircle(
      Offset(275.w, 275.h),
      70.r,
      paint,
    );
    canvas.drawCircle(
      Offset(88.w, 350.h),
      70.r,
      paint,
    );
    canvas.drawCircle(
      Offset(319.w, 350.h),
      70.r,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
