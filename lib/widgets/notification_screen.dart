import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  FocusScope.of(context).unfocus();
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 24.h,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 18.h,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "알림",
                    style: TextStyle(
                      fontSize: 20.h,
                      fontFamily: 'SUITE',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 19.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 383.w,
                    height: 1.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 21.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Container(
              width: 383.w,
              height: 631.h,
              decoration: BoxDecoration(
                color: Color(0xFFF9F8FF),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 17.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 21.w,
                      ),
                      Text(
                        "최근 순 알림",
                        style: TextStyle(
                          fontSize: 10.h,
                          fontFamily: 'SUITE',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
