import 'package:FE/widgets/notification_screen.dart';
import 'package:FE/widgets/ranking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              width: 23.w,
            ),
            Image.asset(
              'assets/main/trophy.png',
              width: 24.h,
              height: 24.h,
            ),
            SizedBox(
              width: 11.w,
            ),
            Text(
              "3등",
              style: TextStyle(
                letterSpacing: 0.5,
                fontSize: 15.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Image.asset(
              'assets/main/coin.png',
              width: 24.h,
              height: 24.h,
            ),
            SizedBox(
              width: 11.w,
            ),
            Text(
              "3000",
              style: TextStyle(
                letterSpacing: 0.5,
                fontSize: 15.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              width: 281.w - 113.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              },
              child: Icon(
                Icons.notifications_none,
                color: Colors.black,
                size: 24.h,
              ),
            ),
          ],
        ),
        SizedBox(height: 22.h),
        Row(
          children: [
            SizedBox(
              width: 208.w,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RankingScreen()),
                );
              },
              child: Container(
                width: 157.w,
                height: 31.h,
                decoration: BoxDecoration(
                  color: Color(0xFFF9F8FF),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 26.w,
                    ),
                    Text(
                      "랭킹 보러가기",
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 101.w - 81.h,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 15.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 16.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/main/rabbit.png',
                  width: 103.w,
                  height: 103.h,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  width: 75.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: Color(0xFFF9F8FF),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "이동현",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 12.w,
            ),
            Container(
              width: 234.w,
              height: 133.h,
              decoration: BoxDecoration(
                color: Color(0xFFF9F8FF),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 23.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 14.w,
                      ),
                      Text(
                        "랭킹",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 164.w - 27.h,
                      ),
                      Text(
                        "1위",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 14.w,
                      ),
                      Text(
                        "누적 점수",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 164.w - 58.h,
                      ),
                      Text(
                        "781",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 14.w,
                      ),
                      Text(
                        "한 주 챌린지",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 164.w - 75.h,
                      ),
                      Image.asset(
                        'assets/main/check.png',
                        width: 15.h,
                        height: 15.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 14.w,
                      ),
                      Text(
                        "지난주 챌린지 점수",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 164.w - 115.h,
                      ),
                      Text(
                        "39",
                        style: TextStyle(
                          letterSpacing: 0.5,
                          fontSize: 15.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30.w,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Color(0xFFF9F8FF),
          ),
          width: 383.w,
          height: 402.h,
          child: Column(
            children: [
              SizedBox(
                height: 14.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/main/magic.png',
                    width: 36.h,
                    height: 36.h,
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    "한 주 챌린지",
                    style: TextStyle(
                      fontSize: 15.h,
                      fontFamily: 'SUITE',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  Image.asset(
                    'assets/main/magic.png',
                    width: 36.h,
                    height: 36.h,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "챌린지에 n 명이 참여 중이에요!",
                    style: TextStyle(
                      fontSize: 15.h,
                      fontFamily: 'SUITE',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "이번 주 테마 : 우주",
                    style: TextStyle(
                      fontSize: 15.h,
                      fontFamily: 'SUITE',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "최고 점수 : 47점",
                    style: TextStyle(
                      fontSize: 15.h,
                      fontFamily: 'SUITE',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
