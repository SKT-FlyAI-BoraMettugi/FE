import 'package:FE/widgets/login_screen.dart';
import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/circle_painter.dart';
import 'package:FE/widgets/info_change.dart';

class MyPageTab extends StatelessWidget {
  String nickname;
  MyPageTab({super.key, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF9F8FF),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 35.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 346.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.notifications_none,
                      size: 24.h,
                    ),
                  ),
                  SizedBox(
                    height: 34.h,
                  ),
                ],
              ),
              SizedBox(
                height: 34.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 23.w,
                  ),
                  Stack(
                    children: [
                      CustomPaint(
                        size: Size(60.h, 60.h),
                        painter: CirclePainter(
                          radius: 30.h,
                          color: Color(0xFFD9D9D9),
                          centerX: 30.h,
                          centerY: 30.h,
                        ),
                      ),
                      Positioned(
                        left: 6.h,
                        top: 6.h,
                        child: Image.asset(
                          'assets/main/rabbit.png',
                          width: 48.h,
                          height: 48.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 21.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            nickname,
                            style: TextStyle(
                              fontFamily: 'SUITE',
                              fontWeight: FontWeight.w600,
                              fontSize: 20.h,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "내 정보 수정",
                            style: TextStyle(
                              fontSize: 20.h,
                              fontFamily: 'SUITE',
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6F6D6D),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 169.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                InfoChange(nickname: nickname)),
                      );
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 24.h,
                      color: Color(0xFFA6A6A6),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 17.h,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "알림",
                      style: TextStyle(
                        fontSize: 20.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: Text(
                      "로그아웃 하실건가요?",
                      style: TextStyle(
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "아니오",
                          style: TextStyle(
                            fontSize: 15.h,
                            fontFamily: 'SUITE',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "예",
                          style: TextStyle(
                            fontSize: 15.h,
                            fontFamily: 'SUITE',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFF9F8FF),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 17.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 22.w,
                  ),
                  Text(
                    "로그아웃",
                    style: TextStyle(
                      color: Color(0xFFFF0000),
                      fontFamily: 'SUITE',
                      fontWeight: FontWeight.w600,
                      fontSize: 20.h,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
