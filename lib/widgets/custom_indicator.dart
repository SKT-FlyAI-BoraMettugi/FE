import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIndicator extends Decoration {
  final Color color;
  final double radius;
  final double width;
  final double offsetY;

  const CustomIndicator({
    required this.color,
    this.radius = 8.0,
    this.width = 32.0,
    this.offsetY = 0.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CustomPainter(
        color: color, radius: radius, width: width, offsetY: offsetY);
  }
}

class _CustomPainter extends BoxPainter {
  final Color color;
  final double radius;
  final double width;
  final double offsetY;

  _CustomPainter(
      {required this.color,
      required this.radius,
      required this.width,
      required this.offsetY});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // indicator의 위치와 크기 설정
    final rect = Rect.fromLTWH(
      40.w,
      25.h,
      width,
      4.h,
    );

    // 원 형태로 indicator 그리기
    canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(radius)), paint);
  }
}
