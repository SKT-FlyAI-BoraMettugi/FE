import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class StrokePainter extends CustomPainter {
  final List<int> score;

  StrokePainter({required this.score});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xFFC1B6B0)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke; // 내부 색상을 채움

    final Path path = Path();

    // 오각형의 중심 좌표
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double distancePerScore = 10.7.w; // 반지름 설정

    for (int i = 0; i < 5; i++) {
      double angle = (pi / 2) + (2 * pi * i / 5); // 72도씩 회전 반시계 방향으로로
      double x = centerX + distancePerScore * score[i] * cos(angle);
      double y = centerY -
          distancePerScore * score[i] * sin(angle); // y 좌표는 위로 증가해야 하므로 -sin 사용
      canvas.drawCircle(Offset(x, y), 2.w, paint);
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
