import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final TextEditingController myanswer = TextEditingController();

  @override
  void dispose() {
    myanswer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      Icons.arrow_back_ios_new,
                      size: 24.h,
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
                      size: 24.h,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              TabBar(
                tabs: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Text(
                      "문제",
                      style: TextStyle(
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Text(
                      "결과",
                      style: TextStyle(
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Text(
                      "토론",
                      style: TextStyle(
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 5.h,
                  ),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: SingleChildScrollView(
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
                                    width: 15.w,
                                  ),
                                  Text(
                                    "답변",
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      fontFamily: 'SUITE',
                                      fontWeight: FontWeight.w600,
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
                                    controller: myanswer,
                                    showCursor: true,
                                    maxLines: 10,
                                    decoration: InputDecoration(
                                      hintText: '답변을 작성해주세요.',
                                      hintStyle: TextStyle(
                                        fontSize: 15.h,
                                        fontFamily: 'SUITE',
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFA6A6A6),
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
                                  FocusScope.of(context).unfocus();
                                  SystemChrome.setEnabledSystemUIMode(
                                      SystemUiMode.immersiveSticky);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                            "알림",
                                          ),
                                          content: Text(
                                              "답변 : ${myanswer.text}\n답변을 제출하시겠습니까?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                            "알림",
                                                          ),
                                                          content:
                                                              Text("답변 제출 완료"),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  myanswer
                                                                      .clear();
                                                                },
                                                                child:
                                                                    Text("확인")),
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: Text("제출")),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  width: 327.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    color: Color(0xFF01D4AD),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "답안 제출",
                                        style: TextStyle(
                                          fontSize: 15.h,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'SUITE',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                              Builder(
                                builder: (context) {
                                  double keyboardHeight =
                                      MediaQuery.of(context).viewInsets.bottom;
                                  return SizedBox(height: keyboardHeight);
                                },
                              ),
                            ],
                          ),
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
                                      left: 164.w,
                                      top: 145.h,
                                      child: CustomPaint(
                                        size: Size(46.h, 42.h),
                                        painter: PentagonPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 164.w - 23.h,
                                      top: 124.h,
                                      child: CustomPaint(
                                        size: Size(92.h, 84.h),
                                        painter: PentagonPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 164.w - 46.h,
                                      top: 103.h,
                                      child: CustomPaint(
                                        size: Size(138.h, 126.h),
                                        painter: PentagonPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 164.w - 69.h,
                                      top: 82.h,
                                      child: CustomPaint(
                                        size: Size(184.h, 168.h),
                                        painter: PentagonPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 164.w - 92.h,
                                      top: 61.h,
                                      child: CustomPaint(
                                        size: Size(230.h, 210.h),
                                        painter: PentagonPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 164.w - 92.h,
                                      top: 61.h,
                                      child: CustomPaint(
                                        size: Size(230.h, 210.h),
                                        painter: GraphPainter(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 164.w - 92.h,
                                      top: 61.h,
                                      child: CustomPaint(
                                        size: Size(230.h, 210.h),
                                        painter: StrokePainter(
                                            score: [8, 8, 6, 2, 1]),
                                      ),
                                    ),
                                    Positioned(
                                      left: 164.w + 10.5.h,
                                      top: 35.h,
                                      child: Text(
                                        "창의",
                                        style: TextStyle(
                                          fontSize: 15.h,
                                          fontFamily: 'SUITE',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 80.w,
                                      top: 120.h,
                                      child: Text(
                                        "깊이",
                                        style: TextStyle(
                                          fontSize: 15.h,
                                          fontFamily: 'SUITE',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 120.w,
                                      top: 255.h,
                                      child: Text(
                                        "설득",
                                        style: TextStyle(
                                          fontSize: 15.h,
                                          fontFamily: 'SUITE',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 225.w,
                                      top: 255.h,
                                      child: Text(
                                        "사고",
                                        style: TextStyle(
                                          fontSize: 15.h,
                                          fontFamily: 'SUITE',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 262.w,
                                      top: 120.h,
                                      child: Text(
                                        "논리",
                                        style: TextStyle(
                                          fontSize: 15.h,
                                          fontFamily: 'SUITE',
                                          fontWeight: FontWeight.w400,
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
                              child: Builder(
                                builder: (context) => Column(
                                  children: [
                                    TabBar(
                                      tabs: [
                                        Text(
                                          "창의",
                                          style: TextStyle(
                                            fontSize: 15.h,
                                            fontFamily: 'SUITE',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "논리",
                                          style: TextStyle(
                                            fontSize: 15.h,
                                            fontFamily: 'SUITE',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "사고",
                                          style: TextStyle(
                                            fontSize: 15.h,
                                            fontFamily: 'SUITE',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "설득",
                                          style: TextStyle(
                                            fontSize: 15.h,
                                            fontFamily: 'SUITE',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "깊이",
                                          style: TextStyle(
                                            fontSize: 15.h,
                                            fontFamily: 'SUITE',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                      indicatorColor: Color(0xFF6F63E1),
                                      labelColor: Colors.black,
                                      unselectedLabelColor: Color(0xFFA6A6A6),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicatorWeight: 2,
                                    ),
                                    SizedBox(
                                      width: 383.w,
                                      height: 268.h,
                                      child: TabBarView(
                                        physics: NeverScrollableScrollPhysics(),
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Container(
                                                width: 361.w,
                                                height: 180.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Container(
                                                width: 361.w,
                                                height: 69.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFE7E8F7),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Container(
                                                width: 361.w,
                                                height: 180.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Container(
                                                width: 361.w,
                                                height: 69.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFE7E8F7),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Container(
                                                width: 361.w,
                                                height: 180.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Container(
                                                width: 361.w,
                                                height: 69.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFE7E8F7),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Container(
                                                width: 361.w,
                                                height: 180.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Container(
                                                width: 361.w,
                                                height: 69.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFE7E8F7),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    Text(
                                                      "설득 점수 :",
                                                      style: TextStyle(
                                                        fontSize: 20.h,
                                                        fontFamily: 'SUITE',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              Container(
                                                width: 361.w,
                                                height: 180.h,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Container(
                                                width: 361.w,
                                                height: 69.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFE7E8F7),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
