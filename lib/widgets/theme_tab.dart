import 'dart:convert';

import 'package:FE/widgets/gettheme_model.dart';
import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/circle_painter.dart';
import 'package:FE/widgets/detailtheme.dart';
import 'package:http/http.dart' as http;

class ThemeTab extends StatefulWidget {
  final int userId;
  final int character_id;
  const ThemeTab({
    super.key,
    required this.character_id,
    required this.userId,
  });

  @override
  State<ThemeTab> createState() => _ThemeTabState();
}

class _ThemeTabState extends State<ThemeTab> {
  late Future<List<GetthemeModel>> topiclist;

  Future<List<GetthemeModel>> getThemeList() async {
    List<GetthemeModel> topicInstances = [];
    final response = await http.get(
        Uri.parse('http://nolly.ap-northeast-2.elasticbeanstalk.com/theme'));
    if (response.statusCode == 200) {
      String decodedbody = utf8.decode(response.bodyBytes);
      final List<dynamic> topics = jsonDecode(decodedbody);
      for (var topic in topics) {
        topicInstances.add(GetthemeModel.fromJson(topic));
      }
      return topicInstances;
    }
    throw Error();
  }

  @override
  void initState() {
    super.initState();
    topiclist = getThemeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEDF1),
      body: Column(
        children: [
          Container(
            width: 393.w,
            height: 170.h,
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
                    )
                  ],
                ),
                SizedBox(
                  height: 53.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "오늘은 어디로 떠나볼까요?",
                      style: TextStyle(
                        fontSize: 30.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          FutureBuilder(
              future: getThemeList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "테마를 불러오는데 실패했습니다.",
                      style: TextStyle(
                        fontSize: 20.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                } else {
                  int listlength = snapshot.data!.length;
                  return SizedBox(
                    width: 393.w,
                    height: 590.h,
                    child: ListView.separated(
                      itemCount: listlength,
                      separatorBuilder: (context, index) => SizedBox(
                        height: 14.h,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Detailtheme(
                                  character_id: widget.character_id,
                                  theme_id: snapshot.data![index].theme_id,
                                  theme_name: snapshot.data![index].theme_name,
                                  background_img:
                                      snapshot.data![index].background_img,
                                  userId: widget.userId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 393.w,
                            height: 76.h,
                            decoration: BoxDecoration(
                              color: Color(0xFFF9F8FF),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 25.w,
                                ),
                                Stack(
                                  children: [
                                    CustomPaint(
                                        size: Size(60.h, 60.h),
                                        painter: CirclePainter(
                                            radius: 30.h,
                                            color: Color(0xFFA6A6A6),
                                            centerX: 30.h,
                                            centerY: 30.h)),
                                    Positioned(
                                      top: 12.h,
                                      left: 12.h,
                                      child: Image.asset(
                                        'assets/theme/${snapshot.data![index].profile_img}',
                                        width: 36.h,
                                        height: 36.h,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 21.w,
                                ),
                                Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 11.h,
                                        ),
                                        Text(
                                          snapshot.data![index].theme_name,
                                          style: TextStyle(
                                            fontSize: 17.h,
                                            fontFamily: 'SUITE',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data![index].theme_ex,
                                          style: TextStyle(
                                            fontSize: 15.h,
                                            fontFamily: 'SUITE',
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFA6A6A6),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 262.w,
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 24.h,
                                  color: Color(0xFFA6A6A6),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
