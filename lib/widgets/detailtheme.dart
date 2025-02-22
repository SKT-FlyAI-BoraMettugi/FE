import 'dart:convert';

import 'package:FE/widgets/getthemedetail_model.dart';
import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/problem_screen.dart';
import 'package:http/http.dart' as http;

class Detailtheme extends StatefulWidget {
  final int theme_id;
  final String theme_name;

  const Detailtheme(
      {super.key, required this.theme_id, required this.theme_name});

  @override
  State<Detailtheme> createState() => _DetailThemeState();
}

class _DetailThemeState extends State<Detailtheme> {
  Color getColorFromApiResponse(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", ""); // '#' 제거

    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // 6자리일 경우 투명도(Alpha) FF 추가
    }

    return Color(int.parse(hexColor, radix: 16));
  }

  Future<List<GetthemedetailModel>> detail() async {
    List<GetthemedetailModel> detailInstances = [];
    final response = await http.get(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/theme/${widget.theme_id}/1'));
    if (response.statusCode == 200) {
      final decodedbody = utf8.decode(response.bodyBytes);
      final List<dynamic> details = jsonDecode(decodedbody);
      for (var detail in details) {
        detailInstances.add(GetthemedetailModel.fromJson(detail));
      }
      return detailInstances;
    }
    throw Error();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: detail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "로딩에 실패했습니다.",
                style: TextStyle(
                  fontSize: 20.h,
                  fontFamily: 'SUITE',
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else {
            return Stack(
              children: [
                Image.asset(
                  "assets/theme/${snapshot.data![0].background_img}",
                  width: 393.w,
                  height: 778.h,
                  fit: BoxFit.fill,
                ),
                Column(
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
                            color: Colors.black,
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
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.theme_name} 월드",
                          style: TextStyle(
                            fontSize: 20.h,
                            fontFamily: 'SUITE',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Container(
                        width: 383.w,
                        height: 1.h,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 136.h,
                      child: SizedBox(
                        width: 393.w,
                        height: 652.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 20.h,
                          ),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 30.h,
                              mainAxisSpacing: 30.h,
                            ),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (index < 5) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProblemScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 75.h,
                                    height: 75.h,
                                    decoration: BoxDecoration(
                                      color: (snapshot.data![index]
                                                  .low_fail_color ==
                                              "#FFFFFF")
                                          ? getColorFromApiResponse(snapshot
                                              .data![index].low_succ_color)
                                          : getColorFromApiResponse(snapshot
                                              .data![index].low_fail_color),
                                      borderRadius: BorderRadius.circular(75.h),
                                      border: Border.all(
                                          color: Color(0xFF142AF2), width: 2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${snapshot.data![index].stage}",
                                        style: TextStyle(
                                          fontSize: 20.h,
                                          fontFamily: 'SUITE',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else if (index < 9) {
                                return Container(
                                  width: 75.h,
                                  height: 75.h,
                                  decoration: BoxDecoration(
                                    color:
                                        (snapshot.data![index].mid_fail_color ==
                                                "#FFFFFF")
                                            ? getColorFromApiResponse(snapshot
                                                .data![index].mid_succ_color)
                                            : getColorFromApiResponse(snapshot
                                                .data![index].mid_fail_color),
                                    borderRadius: BorderRadius.circular(75.h),
                                    border: Border.all(
                                        color: Color(0xFF142AF2), width: 2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${snapshot.data![index].stage}",
                                      style: TextStyle(
                                        fontSize: 20.h,
                                        fontFamily: 'SUITE',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  width: 75.h,
                                  height: 75.h,
                                  decoration: BoxDecoration(
                                    color: (snapshot
                                                .data![index].high_fail_color ==
                                            "#FFFFFF")
                                        ? getColorFromApiResponse(snapshot
                                            .data![index].high_succ_color)
                                        : getColorFromApiResponse(snapshot
                                            .data![index].high_fail_color),
                                    borderRadius: BorderRadius.circular(75.h),
                                    border: Border.all(
                                        color: Color(0xFF142AF2), width: 2),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${snapshot.data![index].stage}",
                                      style: TextStyle(
                                        fontSize: 20.h,
                                        fontFamily: 'SUITE',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
