import 'dart:convert';

import 'package:FE/widgets/circle_painter.dart';
import 'package:FE/widgets/getranking_model.dart';
import 'package:FE/widgets/getuser_model.dart';
import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

Future<List<GetrankingModel>> ranking() async {
  List<GetrankingModel> rankingInstances = [];
  final response = await http.get(
      Uri.parse('http://nolly.ap-northeast-2.elasticbeanstalk.com/ranking'));
  if (response.statusCode == 200) {
    final List<dynamic> ranks = jsonDecode(response.body);
    for (var rank in ranks) {
      rankingInstances.add(GetrankingModel.fromJson(rank));
    }
    return rankingInstances;
  }
  throw Error();
}

Future<GetuserModel> userinfo(int userId) async {
  final response = await http.get(Uri.parse(
      'http://nolly.ap-northeast-2.elasticbeanstalk.com/user/$userId'));
  if (response.statusCode == 200) {
    final decodedbody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> infos = jsonDecode(decodedbody);
    GetuserModel info = GetuserModel.fromJson(infos);
    return info;
  }
  throw Error();
}

Future<List<Map<String, dynamic>>> fetchRankingWithUserInfo() async {
  final rankings = await ranking(); // 랭킹 정보 가져오기

  // 모든 유저 정보를 병렬로 가져오기
  final userInfos = await Future.wait(
    rankings.map(
      (rank) {
        return userinfo(rank.user_id);
      },
    ),
  );

  // 랭킹 정보와 유저 정보를 매핑
  return List.generate(rankings.length, (index) {
    return {
      "rank": rankings[index].rank,
      "score": rankings[index].score,
      "userId": rankings[index].user_id,
      "userName": userInfos[index].nickname,
      "characterImg": userInfos[index].character_id,
    };
  });
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
                    child: FutureBuilder(
                      future: fetchRankingWithUserInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "랭킹 불러오기 실패!",
                              style: TextStyle(
                                fontSize: 20.h,
                                fontFamily: 'SUITE',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ((index + 1 < 4) == true)
                                  ? Row(
                                      children: [
                                        SizedBox(
                                          width: 25.w,
                                          height: 80.h,
                                        ),
                                        Stack(
                                          children: [
                                            Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                fontSize: 10 *
                                                    (4 - 0.5 * (index + 1)).h,
                                                fontFamily: 'SUITE',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80.w,
                                            )
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            CustomPaint(
                                              size: Size(60.h, 60.h),
                                              painter: CirclePainter(
                                                radius: 30.h,
                                                color: Color(0xFFEAF2FF)
                                                    .withValues(alpha: 0),
                                                centerX: 30.h,
                                                centerY: 30.h,
                                              ),
                                            ),
                                            Positioned(
                                              left: 12.h,
                                              top: 12.h,
                                              child: Image.asset(
                                                'assets/character/${snapshot.data![index]['characterImg']}.png',
                                                width: 36.h,
                                                height: 36.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Stack(
                                          children: [
                                            SizedBox(
                                              width: 145.w,
                                            ),
                                            Text(
                                              "${snapshot.data![index]['userName']}",
                                              style: TextStyle(
                                                fontSize: 20.h,
                                                fontFamily: 'SUITE',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${snapshot.data![index]['score']}",
                                          style: TextStyle(
                                            fontSize: 20.h,
                                            fontFamily: 'SUITE',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        SizedBox(
                                          width: 25.w,
                                          height: 80.h,
                                        ),
                                        Stack(
                                          children: [
                                            Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                fontSize: 20.h,
                                                fontFamily: 'SUITE',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 80.w,
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            CustomPaint(
                                              size: Size(60.h, 60.h),
                                              painter: CirclePainter(
                                                radius: 30.h,
                                                color: Color(0xFFEAF2FF)
                                                    .withValues(
                                                  alpha: 0,
                                                ),
                                                centerX: 30.h,
                                                centerY: 30.h,
                                              ),
                                            ),
                                            Positioned(
                                              left: 12.h,
                                              top: 12.h,
                                              child: Image.asset(
                                                'assets/character/${snapshot.data![index]["characterImg"]}.png',
                                                width: 36.h,
                                                height: 36.h,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Stack(
                                          children: [
                                            SizedBox(
                                              width: 145.w,
                                            ),
                                            Text(
                                              "${snapshot.data![index]['userName']}",
                                              style: TextStyle(
                                                fontSize: 20.h,
                                                fontFamily: 'SUITE',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${snapshot.data![index]['score']}",
                                          style: TextStyle(
                                            fontSize: 20.h,
                                            fontFamily: 'SUITE',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    );
                            },
                          );
                        }
                      },
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
