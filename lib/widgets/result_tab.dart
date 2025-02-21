import 'dart:convert';

import 'package:FE/widgets/getresult_model.dart';
import 'package:FE/widgets/graph_painter.dart';
import 'package:FE/widgets/pentagon_painter.dart';
import 'package:FE/widgets/stroke_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ResultTab extends StatefulWidget {
  const ResultTab({
    super.key,
  });

  @override
  State<ResultTab> createState() => _ResultTabState();
}

class _ResultTabState extends State<ResultTab> {
  Future<GetresultModel> result() async {
    final response = await http.get(
      Uri.parse('http://nolly.ap-northeast-2.elasticbeanstalk.com/answer/1/1'),
    );
    if (response.statusCode == 200) {
      String decodedbody = utf8.decode(response.bodyBytes);
      final GetresultModel score =
          GetresultModel.fromJson(jsonDecode(decodedbody));
      return score;
    }
    throw Error();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: result(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "결과가 없습니다.",
              style: TextStyle(
                fontSize: 20.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else {
          return Container(
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
                              score: [
                                snapshot.data!.creativity,
                                snapshot.data!.depth,
                                snapshot.data!.persuasion,
                                snapshot.data!.thinking,
                                snapshot.data!.logic,
                              ],
                            ),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                        horizontal: 23.w,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "창의력",
                                                  style: TextStyle(
                                                    fontSize: 20.h,
                                                    fontFamily: 'SUITE',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text(
                                              snapshot.data!.creativity_review,
                                              style: TextStyle(
                                                fontSize: 15.h,
                                                fontFamily: 'SUITE',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "창의 점수",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            "${snapshot.data!.creativity}/10",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Container(
                                            width: 1.w,
                                            height: 52.h,
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withValues(alpha: 0.1),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            "총점",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            '${snapshot.data!.total_score}/50',
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                        horizontal: 23.w,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "논리력",
                                                  style: TextStyle(
                                                    fontSize: 20.h,
                                                    fontFamily: 'SUITE',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text(
                                              snapshot.data!.logic_review,
                                              style: TextStyle(
                                                fontSize: 15.h,
                                                fontFamily: 'SUITE',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "논리 점수",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            "${snapshot.data!.logic}/10",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Container(
                                            width: 1.w,
                                            height: 52.h,
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withValues(alpha: 0.1),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            "총점",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            '${snapshot.data!.total_score}/50',
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                        horizontal: 23.w,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "사고력",
                                                  style: TextStyle(
                                                    fontSize: 20.h,
                                                    fontFamily: 'SUITE',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text(
                                              snapshot.data!.thinking_review,
                                              style: TextStyle(
                                                fontSize: 15.h,
                                                fontFamily: 'SUITE',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "사고 점수",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            "${snapshot.data!.thinking}/10",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Container(
                                            width: 1.w,
                                            height: 52.h,
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withValues(alpha: 0.1),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            "총점",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            '${snapshot.data!.total_score}/50',
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                        horizontal: 23.w,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "설득력",
                                                  style: TextStyle(
                                                    fontSize: 20.h,
                                                    fontFamily: 'SUITE',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text(
                                              snapshot.data!.persuasion_review,
                                              style: TextStyle(
                                                fontSize: 15.h,
                                                fontFamily: 'SUITE',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "설득 점수",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            "${snapshot.data!.persuasion}/10",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Container(
                                            width: 1.w,
                                            height: 52.h,
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withValues(alpha: 0.1),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            "총점",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            '${snapshot.data!.total_score}/50',
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 16.h,
                                        horizontal: 23.w,
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "추론의 깊이",
                                                  style: TextStyle(
                                                    fontSize: 20.h,
                                                    fontFamily: 'SUITE',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Text(
                                              snapshot.data!.depth_review,
                                              style: TextStyle(
                                                fontSize: 15.h,
                                                fontFamily: 'SUITE',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
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
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "깊이 점수",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            "${snapshot.data!.depth}/10",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Container(
                                            width: 1.w,
                                            height: 52.h,
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withValues(alpha: 0.1),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text(
                                            "총점",
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            '${snapshot.data!.total_score}/50',
                                            style: TextStyle(
                                              fontSize: 20.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
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
          );
        }
      },
    );
  }
}
