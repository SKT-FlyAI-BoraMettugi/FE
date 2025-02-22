import 'dart:convert';
import 'package:FE/widgets/getlike_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/getdiscussion_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Comment {
  String id;
  String userId;
  String userName;
  String userProfileImage;
  String content;
  List<Comment> replies;

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.content,
    this.replies = const [],
  });
}

class DiscussionTab extends StatefulWidget {
  const DiscussionTab({super.key});

  @override
  State<DiscussionTab> createState() => _DiscusstionTabState();
}

class _DiscusstionTabState extends State<DiscussionTab> {
  TextEditingController comment = TextEditingController();
  TextEditingController reply = TextEditingController();

  Future<List<GetdiscussionModel>> discussion() async {
    List<GetdiscussionModel> discussionInstances = [];
    final response = await http.get(
      Uri.parse(
          'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/1'),
    );
    if (response.statusCode == 200) {
      String decodedbody = utf8.decode(response.bodyBytes);
      final List<dynamic> discussions = jsonDecode(decodedbody);
      for (var discussion in discussions) {
        discussionInstances.add(GetdiscussionModel.fromJson(discussion));
      }
      return discussionInstances;
    }
    throw Error();
  }

  Future<void> postcomment() async {
    final response = await http.post(
      Uri.parse(
          'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/1/1'),
      body: utf8.encode(
        jsonEncode(
          {
            "content": comment.text,
          },
        ),
      ),
    );
  }

  Future<List<GetlikeModel>> favorite() async {
    List<GetlikeModel> likeInstances = [];
    final response = await http.patch(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/like/1/1'));
    if (response.statusCode == 200) {
      final List<dynamic> favorites = jsonDecode(response.body);
      for (var favorite in favorites) {
        likeInstances.add(GetlikeModel.fromJson(favorite));
      }
      return likeInstances;
    }
    throw Error();
  }

  Future<void> postreply() async {
    final response = await http.post(
      Uri.parse('http://nolly.ap-northeast-2.elasticbeanstalk.com/comment/1/1'),
      body: utf8.encode(
        jsonEncode(
          {
            "content": reply.text,
          },
        ),
      ),
    );
  }

  String timeAgo(String dateTimeString) {
    DateTime commentTime = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(commentTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds}초 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return DateFormat('yyyy-MM-dd').format(commentTime); // 1주 이상이면 날짜 표시
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: discussion(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "토론을 불러오는데 실패했습니다.",
                style: TextStyle(
                  fontSize: 20.h,
                  fontFamily: 'SUITE',
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          } else {
            return SizedBox(
                width: 393.w,
                height: 580.h,
                child: ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.h,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF6F5FF),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 5.h,
                                right: 10.w,
                                left: 5.h,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 67.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${snapshot.data![index].user_id}",
                                            style: TextStyle(
                                              fontSize: 15.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            timeAgo(snapshot
                                                .data![index].created_date),
                                            style: TextStyle(
                                              fontSize: 10.h,
                                              fontFamily: 'SUITE',
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFFA6A6A6),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 247.w - 71.h,
                                          ),
                                          Icon(
                                            Icons.favorite_border,
                                            size: 14.h,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Stack(children: [
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Text(
                                              "${snapshot.data![index].like}",
                                              style: TextStyle(
                                                fontSize: 10.h,
                                                fontFamily: 'SUITE',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),
                                      Text(
                                        snapshot.data![index].content,
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
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ));
          }
        });
  }
}
