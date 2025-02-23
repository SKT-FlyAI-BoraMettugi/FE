import 'dart:convert';
import 'package:FE/widgets/getlike_model.dart';
import 'package:FE/widgets/getresult_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/getdiscussion_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DiscussionTab extends StatefulWidget {
  final int questionID;

  const DiscussionTab({super.key, required this.questionID});

  @override
  State<DiscussionTab> createState() => _DiscusstionTabState();
}

class _DiscusstionTabState extends State<DiscussionTab> {
  late int totalScore;
  late Map<int, int> likeCount = {};
  late int likereply;

  TextEditingController comment = TextEditingController();
  TextEditingController reply = TextEditingController();

  Future<List<GetdiscussionModel>> discussion() async {
    List<GetdiscussionModel> discussionInstances = [];

    final response = await http.get(
      Uri.parse(
          'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/${widget.questionID}'),
    );
    if (response.statusCode == 200) {
      String decodedbody = utf8.decode(response.bodyBytes);
      final List<dynamic> discussions = jsonDecode(decodedbody);
      for (var discussion in discussions) {
        discussionInstances.add(GetdiscussionModel.fromJson(discussion));
        if (!likeCount.containsKey(
            GetdiscussionModel.fromJson(discussion).discussion_id)) {
          fetchcommentlike(
              GetdiscussionModel.fromJson(discussion).discussion_id);
        }
      }
      return discussionInstances;
    }
    throw Error();
  }

  Future<int> result() async {
    final response = await http.get(
      Uri.parse(
          'http://nolly.ap-northeast-2.elasticbeanstalk.com/answer/1/${widget.questionID}'),
    );
    if (response.statusCode == 200) {
      String decodedbody = utf8.decode(response.bodyBytes);
      final GetresultModel score =
          GetresultModel.fromJson(jsonDecode(decodedbody));
      return score.total_score;
    }
    throw Error();
  }

  void fetchscore() async {
    int score = await result();
    setState(() {
      totalScore = score;
    });
  }

  Future<void> postcomment() async {
    await http.post(
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

  Future<void> postreply() async {
    await http.post(
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

  Future<int> commentlike(int discussionId) async {
    final response = await http.patch(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/like/$discussionId/1'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> commentlikes = jsonDecode(response.body);
      final GetlikeModel commentlike = GetlikeModel.fromJson(commentlikes);
      return commentlike.like;
    }
    throw Error();
  }

  Future<int> replylike(int commentId) async {
    final response = await http.patch(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/like//comment/like/$commentId/1'));
    if (response.statusCode == 200) {
      final Map<String, int> replylikes = jsonDecode(response.body);
      final GetlikeModel replylike = GetlikeModel.fromJson(replylikes);
      return replylike.like;
    }
    throw Error();
  }

  void fetchcommentlike(int discussionId) async {
    final like = await commentlike(discussionId);
    setState(() {
      likeCount[discussionId] = like;
    });
  }

  void fetchreplylike(int commentId) async {
    final like = await replylike(commentId);
    setState(() {
      likereply = like;
    });
  }

  Future<Map<String, dynamic>> fetchData() async {
    final responses = await Future.wait([
      discussion(),
    ]);

    return {
      'api1': responses[0],
      'api2': responses[1],
      'api3': responses[2],
    };
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
  void initState() {
    super.initState();
    fetchscore();
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
              "진행중인 토론이 없습니다.",
              style: TextStyle(
                fontSize: 20.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else {
          if (totalScore >= 35) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        GestureDetector(
                                          onTap: () {
                                            fetchcommentlike(snapshot
                                                .data![index].discussion_id);
                                          },
                                          child: (likeCount[snapshot
                                                      .data![index]
                                                      .discussion_id] ==
                                                  0)
                                              ? Icon(
                                                  Icons.favorite_border,
                                                  size: 14.h,
                                                  color: Colors.red,
                                                )
                                              : Icon(
                                                  Icons.favorite,
                                                  size: 14.h,
                                                  color: Colors.red,
                                                ),
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
              ),
            );
          } else {
            return Center(
              child: Text(
                "토론은 문제를 푼 이후에 확인 가능합니다.",
                style: TextStyle(
                  fontSize: 20.h,
                  fontFamily: 'SUITE',
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
        }
      },
    );
  }
}
