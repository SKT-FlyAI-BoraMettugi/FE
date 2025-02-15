import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/circle_painter.dart';
import 'package:FE/widgets/problem_screen.dart';

class SpaceTheme extends StatefulWidget {
  const SpaceTheme({super.key});

  @override
  State<SpaceTheme> createState() => _SpaceThemeState();
}

class _SpaceThemeState extends State<SpaceTheme> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProblemScreen(),
                ),
              );
            },
            child: CustomPaint(
              size: Size(60.w, 60.h),
              painter: CirclePainter(
                radius: 30.w,
                color: Color(0xFFCCF939).withValues(alpha: 0.3),
                centerX: 30.w,
                centerY: 30.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
