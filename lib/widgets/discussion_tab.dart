import 'dart:convert';
import 'package:FE/widgets/getcomment_model.dart';
import 'package:FE/widgets/getlike_model.dart';
import 'package:FE/widgets/getresult_model.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/getdiscussion_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DiscussionTab extends StatefulWidget {
  final int questionID;
  final String theme_name;

  const DiscussionTab(
      {super.key, required this.questionID, required this.theme_name});

  @override
  State<DiscussionTab> createState() => _DiscusstionTabState();
}

class _DiscusstionTabState extends State<DiscussionTab> {
  int totalScore = 0;
  late int likediscussion;
  late int likecomment;

  TextEditingController discussion = TextEditingController();
  TextEditingController comment = TextEditingController();
  ScrollController discussionList = ScrollController();
  late FocusNode focusnodec;

  Future<List<GetdiscussionModel>> getdiscussion() async {
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
      }
      return discussionInstances;
    }
    throw Error();
  }

  Future<List<GetcommentModel>> getcomment(int discussionId) async {
    List<GetcommentModel> commentInstances = [];
    final response = await http.get(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/comment/$discussionId'));
    if (response.statusCode == 200) {
      String decodedbody = utf8.decode(response.bodyBytes);
      final List<dynamic> comments = jsonDecode(decodedbody);
      for (var comment in comments) {
        commentInstances.add(GetcommentModel.fromJson(comment));
      }
      return commentInstances;
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
    return 40;
  }

  void fetchscore() async {
    int score = await result();
    setState(() {
      totalScore = score;
    });
  }

  Future<void> postdiscussion() async {
    await http.post(
      Uri.parse(
          'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/1/${widget.questionID}'),
      body: utf8.encode(
        jsonEncode(
          {
            "content": discussion.text,
          },
        ),
      ),
    );
  }

  Future<void> postcomment(int discussionId) async {
    await http.post(
      Uri.parse(
          'http://nolly.ap-northeast-2.elasticbeanstalk.com/comment/1/$discussionId'),
      body: utf8.encode(
        jsonEncode(
          {
            "content": comment.text,
          },
        ),
      ),
    );
  }

  Future<int> discussionlike(int discussionId) async {
    final response = await http.patch(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/like/$discussionId/1'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> discussionlikes = jsonDecode(response.body);
      final GetlikeModel discussionlike =
          GetlikeModel.fromJson(discussionlikes);
      {
        return discussionlike.like;
      }
    }
    throw Error();
  }

  Future<int> commentlike(int commentId) async {
    final response = await http.patch(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/like/comment/like/$commentId/1'));
    if (response.statusCode == 200) {
      final Map<String, int> replylikes = jsonDecode(response.body);
      final GetlikeModel replylike = GetlikeModel.fromJson(replylikes);
      return replylike.like;
    }
    throw Error();
  }

  void fetchdiscussionlike(int discussionId) async {
    final like = await commentlike(discussionId);
    setState(() {
      likediscussion = like;
    });
  }

  void fetchcommentlike(int commentId) async {
    final like = await commentlike(commentId);
    setState(() {
      likecomment = like;
    });
  }

  Future<Map<String, dynamic>> fetchData() async {
    final responses = await Future.wait([
      getdiscussion(),
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
    focusnodec = FocusNode();
  }

  @override
  void dispose() {
    discussion.dispose();
    comment.dispose();
    focusnodec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
          future: getdiscussion(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError | (snapshot.data == null)) {
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
                return Column(
                  children: [
                    SizedBox(
                      width: 393.w,
                      height: 560.h,
                      child: ListView.separated(
                        itemCount: snapshot.data!.length + 1,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 8.h,
                        ),
                        itemBuilder: (context, index) {
                          if (index == snapshot.data!.length) {
                            return SizedBox(
                                height:
                                    MediaQuery.of(context).viewInsets.bottom);
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      Container(
                                        width: 345.w,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF6F5FF),
                                          borderRadius:
                                              BorderRadius.circular(20.r),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 13.w,
                                            ),
                                            Stack(children: [
                                              Container(
                                                width: 42.h,
                                                height: 42.h,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFEAF2FF),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          42.h),
                                                ),
                                              ),
                                              Positioned(
                                                left: 7.h,
                                                top: 7.h,
                                                child: Image.asset(
                                                  'assets/main/rabbit.png',
                                                  width: 28.h,
                                                  height: 28.h,
                                                ),
                                              )
                                            ]),
                                            SizedBox(
                                              width: 12.w,
                                            ),
                                            SizedBox(
                                              width: 230.w,
                                              child: Column(
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
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        timeAgo(snapshot
                                                            .data![index]
                                                            .created_date),
                                                        style: TextStyle(
                                                          fontSize: 10.h,
                                                          fontFamily: 'SUITE',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Color(0xFFA6A6A6),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: 8.h,
                                                    ),
                                                    child: Text(
                                                      snapshot
                                                          .data![index].content,
                                                      style: TextStyle(
                                                        fontSize: 15.h,
                                                        fontFamily: 'SUITE',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      softWrap: true,
                                                      maxLines: null,
                                                      overflow:
                                                          TextOverflow.visible,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        fetchdiscussionlike(
                                                            snapshot
                                                                .data![index]
                                                                .discussion_id);
                                                      },
                                                      child: (0 == 0)
                                                          ? Icon(
                                                              Icons
                                                                  .favorite_border,
                                                              size: 14.h,
                                                              color: Color(
                                                                  0xFF006FFD),
                                                            )
                                                          : Icon(
                                                              Icons.favorite,
                                                              size: 14.h,
                                                              color: Color(
                                                                  0xFF006FFD),
                                                            ),
                                                    ),
                                                    SizedBox(
                                                      width: 2.w,
                                                    ),
                                                    Text(
                                                      "${snapshot.data![index].like}",
                                                      style: TextStyle(
                                                        fontSize: 10.h,
                                                        fontFamily: 'SUITE',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    comment.text =
                                                        discussion.text;
                                                    postcomment(snapshot
                                                        .data![index]
                                                        .discussion_id);
                                                    discussion.clear();
                                                    comment.clear();
                                                  },
                                                  child: Text(
                                                    "답글",
                                                    style: TextStyle(
                                                      fontSize: 15.h,
                                                      fontFamily: 'SUITE',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  FutureBuilder(
                                    future: getcomment(
                                        snapshot.data![index].discussion_id),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError |
                                          (snapshot.data == null)) {
                                        return SizedBox(
                                          height: 0.h,
                                        );
                                      } else {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            top: 8.h,
                                            left: 16.w,
                                          ),
                                          child: SizedBox(
                                            width: 340.w,
                                            height: 100.h,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 33.w,
                                                    ),
                                                    Container(
                                                      width: 310.w,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFF6F5FF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.r),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 13.w,
                                                          ),
                                                          Stack(children: [
                                                            Container(
                                                              width: 42.h,
                                                              height: 42.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFEAF2FF),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            42.h),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 7.h,
                                                              top: 7.h,
                                                              child:
                                                                  Image.asset(
                                                                'assets/main/rabbit.png',
                                                                width: 28.h,
                                                                height: 28.h,
                                                              ),
                                                            )
                                                          ]),
                                                          SizedBox(
                                                            width: 12.w,
                                                          ),
                                                          SizedBox(
                                                            width: 215.w,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 5.h,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      "${snapshot.data![index].comment_id}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15.h,
                                                                        fontFamily:
                                                                            'SUITE',
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                    Text(
                                                                      timeAgo(snapshot
                                                                          .data![
                                                                              index]
                                                                          .created_date),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            10.h,
                                                                        fontFamily:
                                                                            'SUITE',
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: Color(
                                                                            0xFFA6A6A6),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    bottom: 8.h,
                                                                  ),
                                                                  child: Text(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .content,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15.h,
                                                                      fontFamily:
                                                                          'SUITE',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                    softWrap:
                                                                        true,
                                                                    maxLines:
                                                                        null,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .visible,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 10.h,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: () {
                                                                      fetchcommentlike(snapshot
                                                                          .data![
                                                                              index]
                                                                          .comment_id);
                                                                    },
                                                                    child: (0 ==
                                                                            0)
                                                                        ? Icon(
                                                                            Icons.favorite_border,
                                                                            size:
                                                                                14.h,
                                                                            color:
                                                                                Color(0xFF006FFD),
                                                                          )
                                                                        : Icon(
                                                                            Icons.favorite,
                                                                            size:
                                                                                14.h,
                                                                            color:
                                                                                Color(0xFF006FFD),
                                                                          ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  Text(
                                                                    "${snapshot.data![index].like}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          10.h,
                                                                      fontFamily:
                                                                          'SUITE',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
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
        ),
        SizedBox(
          height: 10.h,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 70.w,
                  ),
                  Container(
                    width: 298.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 230.w,
                            height: 46.h,
                            child: TextField(
                              showCursor: true,
                              textAlignVertical: TextAlignVertical.center,
                              minLines: 1,
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText:
                                    "${widget.theme_name} 문제 ${widget.questionID}번에 의견 남기기",
                                hintStyle: TextStyle(
                                  fontSize: 15.h,
                                  fontFamily: 'SUITE',
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFA6A6A6),
                                ),
                                border: InputBorder.none,
                              ),
                              controller: discussion,
                              style: TextStyle(
                                fontSize: 15.h,
                                fontFamily: 'SUITE',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (discussion.text.isNotEmpty == true) {
                                FocusScope.of(context).unfocus();
                                SystemChrome.setEnabledSystemUIMode(
                                    SystemUiMode.immersiveSticky);
                                postdiscussion();
                                discussion.clear();
                              }
                            },
                            child: Container(
                              width: 38.h,
                              height: 38.h,
                              decoration: BoxDecoration(
                                color: Color(0xFFB1B2FF),
                                borderRadius: BorderRadius.circular(12.h),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.send_outlined,
                                  size: 24.h,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              (MediaQuery.of(context).viewInsets.bottom != 0)
                  ? SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom - 90,
                    )
                  : SizedBox(
                      height: 0,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
