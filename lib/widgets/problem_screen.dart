import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/graph_painter.dart';
import 'package:FE/widgets/pentagon_painter.dart';
import 'package:FE/widgets/stroke_painter.dart';

class ProblemScreen extends StatefulWidget {
  const ProblemScreen({super.key});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  final TextEditingController _controller = TextEditingController();
  String _savedText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFEEEDF1),
        body: DefaultTabController(
          length: 3,
          child: Column(
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
                      Icons.arrow_back_ios,
                      size: 24.w,
                    ),
                  ),
                  SizedBox(
                    width: 299.w,
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
                      size: 24.w,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 39.h,
              ),
              TabBar(
                tabs: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Text(
                      "문제",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Text(
                      "결과",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Text(
                      "토론",
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                indicatorColor: Color(0xFF01D4AD),
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: 383.w,
                              height: 600.h,
                              decoration: BoxDecoration(
                                color: Color(0xFFF9F8FF),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 29.w,
                                ),
                                Text(
                                  "답변",
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            Container(
                              width: 383.w,
                              height: 240.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 3.h,
                                ),
                                child: TextField(
                                  showCursor: true,
                                  maxLines: 10,
                                  decoration: InputDecoration(
                                    hintText: '답변을 작성해주세요.',
                                    hintStyle: TextStyle(
                                      fontSize: 17.sp,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _savedText = _controller.text;
                                  print(_savedText); // 입력된 텍스트를 저장
                                });
                              },
                              child: Container(
                                width: 327.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Color(0xFF01D4AD),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 128.w,
                                    vertical: 12.5.h,
                                  ),
                                  child: Text(
                                    "답안 제출",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 14.h,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 383.w,
                        height: 648.h,
                        decoration: BoxDecoration(
                          color: Color(0xFFF9F8FF),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: 8.h,
                                left: 11.w,
                                right: 11.w,
                              ),
                              child: Container(
                                width: 361.w,
                                height: 311.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 161.w,
                                      top: 145.h,
                                      child: CustomPaint(
                                        size: Size(46.w, 42.h),
                                        painter: PentagonPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 138.w,
                                      top: 124.h,
                                      child: CustomPaint(
                                        size: Size(92.w, 84.h),
                                        painter: PentagonPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 115.w,
                                      top: 103.h,
                                      child: CustomPaint(
                                        size: Size(138.w, 126.h),
                                        painter: PentagonPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 92.w,
                                      top: 82.h,
                                      child: CustomPaint(
                                        size: Size(184.w, 168.h),
                                        painter: PentagonPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 69.w,
                                      top: 61.h,
                                      child: CustomPaint(
                                        size: Size(230.w, 210.h),
                                        painter: PentagonPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 69.w,
                                      top: 61.h,
                                      child: CustomPaint(
                                        size: Size(230.w, 210.h),
                                        painter: GraphPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 69.w,
                                      top: 61.h,
                                      child: CustomPaint(
                                        size: Size(230.w, 210.h),
                                        painter: StrokePainter(
                                            score: [8, 8, 6, 2, 1]),
                                      ),
                                    ),
                                    Positioned(
                                      left: 173.w,
                                      top: 40.h,
                                      child: Text(
                                        "창의",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 53.w,
                                      top: 120.h,
                                      child: Text(
                                        "깊이",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 105.w,
                                      top: 255.h,
                                      child: Text(
                                        "설득",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 240.w,
                                      top: 255.h,
                                      child: Text(
                                        "사고",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 293.w,
                                      top: 120.h,
                                      child: Text(
                                        "논리",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            DefaultTabController(
                              length: 5,
                              child: Column(
                                children: [
                                  TabBar(
                                    tabs: [
                                      Text(
                                        "창의",
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "논리",
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "사고",
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "설득",
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "깊이",
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                    indicatorColor: Color(0xFF6F63E1),
                                    labelColor: Colors.black,
                                    unselectedLabelColor: Colors.grey,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicatorWeight: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 383.w,
                        height: 648.h,
                        decoration: BoxDecoration(
                          color: Color(0xFFF9F8FF),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
