import 'package:FE/widgets/circle_painter.dart';
import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFEEEDF1),
        body: Column(
          children: [
            SizedBox(
              height: 35.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 23.w,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 24.h,
                  ),
                ),
                SizedBox(
                  width: 323.w - 24.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationScreen()),
                    );
                  },
                  child: Icon(
                    Icons.notifications_none,
                    size: 24.h,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 18.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "누적 랭킹",
                  style: TextStyle(
                    fontSize: 20.h,
                    fontFamily: 'SUITE',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 9.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Container(
                width: 383.w,
                height: 1.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            Container(
              width: 383.w,
              height: 620.h,
              decoration: BoxDecoration(
                color: Color(0xFFF9F8FF),
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  colors: [Color(0xFFD9D9D9), Color(0xFFF9F8FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 21.w,
                      ),
                      Text(
                        "랭킹",
                        style: TextStyle(
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 118.w - 27.h,
                      ),
                      Text(
                        "이름",
                        style: TextStyle(
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 169.w - 27.h,
                      ),
                      Text(
                        "점수",
                        style: TextStyle(
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  SizedBox(
                    width: 383.w,
                    height: 566.h,
                    child: ListView(
                      children: [
                        for (int i = 1; i < 21; i++)
                          if (i < 4)
                            Row(
                              children: [
                                SizedBox(
                                  width: 12.w,
                                  height: 80.h,
                                ),
                                Stack(
                                  children: [
                                    Text(
                                      "$i",
                                      style: TextStyle(
                                        fontSize: 10 * (4 - 0.5 * i).h,
                                        fontFamily: 'SUITE',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 90.w,
                                    )
                                  ],
                                ),
                                Stack(
                                  children: [
                                    CustomPaint(
                                      size: Size(60.h, 60.h),
                                      painter: CirclePainter(
                                        radius: 30.h,
                                        color: Color(0xFFEAF2FF),
                                        centerX: 30.h,
                                        centerY: 30.h,
                                      ),
                                    ),
                                    Positioned(
                                      left: 12.h,
                                      top: 12.h,
                                      child: Image.asset(
                                        'assets/main/rabbit.png',
                                        width: 36.h,
                                        height: 36.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          else
                            Row(
                              children: [
                                SizedBox(
                                  width: 12.w,
                                  height: 80.h,
                                ),
                                Stack(
                                  children: [
                                    Text(
                                      "$i",
                                      style: TextStyle(
                                        fontSize: 20.h,
                                        fontFamily: 'SUITE',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 90.w,
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    CustomPaint(
                                      size: Size(60.h, 60.h),
                                      painter: CirclePainter(
                                        radius: 30.h,
                                        color: Color(0xFFEAF2FF),
                                        centerX: 30.h,
                                        centerY: 30.h,
                                      ),
                                    ),
                                    Positioned(
                                      left: 12.h,
                                      top: 12.h,
                                      child: Image.asset(
                                        'assets/main/rabbit.png',
                                        width: 36.h,
                                        height: 36.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
