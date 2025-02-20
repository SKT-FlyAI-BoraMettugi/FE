import 'package:FE/widgets/circle_painter.dart';
import 'package:FE/widgets/problem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeButton extends StatefulWidget {
  final Color colorCleared;
  final Color colorUnCleared;
  final double xpos;
  final double ypos;
  final bool isCleared;

  const ThemeButton({
    super.key,
    required this.colorCleared,
    required this.colorUnCleared,
    required this.xpos,
    required this.ypos,
    required this.isCleared,
  });

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.ypos,
      left: widget.xpos,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProblemScreen()),
          );
        },
        child: CustomPaint(
          size: Size(75.h, 75.h),
          painter: CirclePainter(
            radius: 37.5.h,
            color:
                widget.isCleared ? widget.colorCleared : widget.colorUnCleared,
            centerX: 37.5.h,
            centerY: 37.5.h,
          ),
        ),
      ),
    );
  }
}
