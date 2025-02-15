import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/elipse_painter.dart';

class MainTab extends StatelessWidget {
  const MainTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 35.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 12.w,
            ),
            Image.asset(
              'assets/main/trophy.png',
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "3등",
              style: TextStyle(
                fontSize: 17.sp,
              ),
            ),
            SizedBox(
              width: 29.w,
            ),
            Image.asset(
              'assets/main/coin.png',
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "3000",
              style: TextStyle(
                fontSize: 17.sp,
              ),
            ),
            SizedBox(
              width: 172.w,
            ),
            Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 24.w,
            ),
            SizedBox(
              width: 23.w,
            )
          ],
        ),
        SizedBox(height: 72.h),
        Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(393.w, 221.h),
              painter: EllipsePainter(),
            ),
            Positioned(
              top: 0.h,
              left: 99.w,
              child: Image.asset(
                'assets/main/rabbit.png',
                width: 195.w,
                height: 195.h,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24.h,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Color(0xFFF9F8FF),
          ),
          width: 383.w,
          height: 385.h,
          child: Column(
            children: [
              SizedBox(
                height: 14.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 105.w,
                  ),
                  Image.asset(
                    'assets/main/magic.png',
                    width: 36.w,
                    height: 36.h,
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    "한 주 챌린지",
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Image.asset(
                    'assets/main/magic.png',
                    width: 36.w,
                    height: 36.w,
                  ),
                  SizedBox(
                    width: 105.w,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 74.w,
                  ),
                  Text(
                    "챌린지에 n 명이 참여 중이에요!",
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  SizedBox(
                    width: 74.w,
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
