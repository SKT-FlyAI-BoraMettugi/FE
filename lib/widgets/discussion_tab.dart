import 'dart:convert';
import 'package:FE/widgets/getcomment_model.dart';
import 'package:FE/widgets/getlike_model.dart';
import 'package:FE/widgets/getresult_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/getdiscussion_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DiscussionTab extends StatefulWidget {
  final int questionID;
  final int themeID;
  final String theme_name;

  const DiscussionTab({
    super.key,
    required this.questionID,
    required this.theme_name,
    required this.themeID,
  });

  @override
  State<DiscussionTab> createState() => _DiscusstionTabState();
}

class _DiscusstionTabState extends State<DiscussionTab> {
  int totalScore = 0;

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
    } else if (response.statusCode == 404) {
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
    } else if (response.statusCode == 404) {
      return commentInstances;
    }
    throw Error();
  }

  Future<List<GetdiscussionModel>> getuserlikediscussion() async {
    List<GetdiscussionModel> discussionlikeInstances = [];
    final response = await http.get(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/like/1'));
    if (response.statusCode == 200) {
      String decodedbody = utf8.decode(response.bodyBytes);
      final List<dynamic> discussionlikes = jsonDecode(decodedbody);
      for (var discussionlike in discussionlikes) {
        discussionlikeInstances
            .add(GetdiscussionModel.fromJson(discussionlike));
      }
      return discussionlikeInstances;
    } else if (response.statusCode == 404) {
      return discussionlikeInstances;
    }
    throw Error();
  }

  Future<List<GetcommentModel>> getuserlikecomment() async {
    List<GetcommentModel> commentlikeInstances = [];
    final response = await http.get(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/comment/like/1'));
    if (response.statusCode == 200) {
      String decodedbody = utf8.decode(response.bodyBytes);
      final List<dynamic> commentlikes = jsonDecode(decodedbody);
      for (var commentlike in commentlikes) {
        commentlikeInstances.add(GetcommentModel.fromJson(commentlike));
      }
      return commentlikeInstances;
    } else if (response.statusCode == 404) {
      return commentlikeInstances;
    }
    throw Error();
  }

  Future<String> getbadge() async {
    final response = await http.get(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/badges/1/${widget.themeID}'));
    if (response.statusCode == 200) {
      String decodedbody = utf8.decode(response.bodyBytes);
      return decodedbody;
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
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/comment/like/$commentId/1'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> commentlikes = jsonDecode(response.body);
      final GetlikeModel commentlike = GetlikeModel.fromJson(commentlikes);
      return commentlike.like;
    }
    throw Error();
  }

  List<GetdiscussionModel> discussions = [];
  Map<int, List<GetcommentModel>> comments = {};
  Set<int> likedDiscussions = {};
  Set<int> likedComments = {};
  Set<int> expandedDiscussions = {}; // 답글 펼쳐진 댓글 ID 저장
  Map<int, int> discussionLikes = {};
  Map<int, int> commentLikes = {};
  TextEditingController discussionController = TextEditingController();
  Map<int, TextEditingController> commentControllers = {};

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchscore();
  }

  Future<void> fetchData() async {
    discussions = await getdiscussion();
    var likedDiscussionList = await getuserlikediscussion();
    var likedCommentList = await getuserlikecomment();

    likedDiscussions = likedDiscussionList.map((e) => e.discussion_id).toSet();
    likedComments = likedCommentList.map((e) => e.comment_id).toSet();

    for (var discussion in discussions) {
      discussionLikes[discussion.discussion_id] = discussion.like;
    }

    for (var comment in likedCommentList) {
      commentLikes[comment.comment_id] = comment.like;
    }

    setState(() {});
  }

  Future<void> postdiscussion() async {
    if (discussionController.text.isEmpty) return;
    await http.post(
      Uri.parse(
          'http://nolly.ap-northeast-2.elasticbeanstalk.com/discussion/1/${widget.questionID}'),
      body: utf8.encode(jsonEncode({"content": discussionController.text})),
    );
    discussionController.clear();
    fetchData();
  }

  Future<void> postcomment(int discussionId) async {
    if (commentControllers[discussionId]!.text.isEmpty) return;
    await http.post(
      Uri.parse(
          'http://nolly.ap-northeast-2.elasticbeanstalk.com/comment/1/$discussionId'),
      body: utf8.encode(
          jsonEncode({"content": commentControllers[discussionId]!.text})),
    );
    commentControllers[discussionId]!.clear();
    comments[discussionId] = await getcomment(discussionId);
    setState(() {});
  }

  Future<void> toggleDiscussionLike(int discussionId) async {
    int updatedLike = await discussionlike(discussionId);
    setState(() {
      discussionLikes[discussionId] = updatedLike;
      if (updatedLike == 1) {
        likedDiscussions.add(discussionId);
      } else {
        likedDiscussions.remove(discussionId);
      }
    });
  }

  Future<void> toggleCommentLike(int commentId) async {
    try {
      int updatedLike = await commentlike(commentId);

      setState(() {
        commentLikes[commentId] = updatedLike;

        if (updatedLike > 0) {
          likedComments.add(commentId);
        } else {
          likedComments.remove(commentId);
        }
      });
    } catch (e) {
      print("❌ 답글 좋아요 처리 중 오류 발생: $e");
    }
  }

  void toggleExpand(int discussionId) async {
    if (expandedDiscussions.contains(discussionId)) {
      setState(() {
        expandedDiscussions.remove(discussionId);
      });
    } else {
      try {
        List<GetcommentModel> fetchedComments = await getcomment(discussionId);

        setState(() {
          expandedDiscussions.add(discussionId);
          comments[discussionId] = fetchedComments;

          for (var comment in fetchedComments) {
            commentLikes[comment.comment_id] = comment.like;
          }
        });
      } catch (e) {
        print("❌ 답글 불러오기 실패: $e");
      }
    }
  }

  String timeAgo(String dateTimeString) {
    DateTime commentTime = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(commentTime);

    if (difference.inSeconds < 60) return '${difference.inSeconds}초 전';
    if (difference.inMinutes < 60) return '${difference.inMinutes}분 전';
    if (difference.inHours < 24) return '${difference.inHours}시간 전';
    if (difference.inDays < 7) return '${difference.inDays}일 전';
    return DateFormat('yyyy-MM-dd').format(commentTime);
  }

  @override
  Widget build(BuildContext context) {
    if (totalScore < 36) {
      return Center(
        child: Text(
          "토론에 참여하기 위해서는 문제를 풀어야 합니다.",
          style: TextStyle(
            fontSize: 20.h,
            fontFamily: 'SUITE',
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Color(0xFFEEEDF1),
        body: SizedBox(
          width: 393.w,
          height: 630.h,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: discussions.length,
                  itemBuilder: (context, index) {
                    var discussion = discussions[index];
                    commentControllers.putIfAbsent(discussion.discussion_id,
                        () => TextEditingController());
                    bool isExpanded =
                        expandedDiscussions.contains(discussion.discussion_id);

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 5.h,
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            tileColor: Color(0xFFF6F5FF),
                            leading: Stack(
                              children: [
                                Image.asset(
                                  'assets/main/rabbit.png',
                                  width: 42.h,
                                  height: 42.h,
                                ),
                                Positioned(
                                  top: 22.h,
                                  left: 24.h,
                                  child: FutureBuilder(
                                    future: getbadge(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return SizedBox(
                                          width: 0.h,
                                        );
                                      } else {
                                        if (snapshot.data == null) {
                                          return SizedBox(
                                            width: 0.h,
                                          );
                                        } else if (snapshot.data! == "동") {
                                          return Image.asset(
                                            'assets/badge/bronze.png',
                                            width: 20.h,
                                            height: 20.h,
                                          );
                                        } else if (snapshot.data! == "은") {
                                          return Image.asset(
                                            'assets/badge/silver.png',
                                            width: 20.h,
                                            height: 20.h,
                                          );
                                        } else {
                                          return Image.asset(
                                            'assets/badge/gold.png',
                                            width: 20.h,
                                            height: 20.h,
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              discussion.content,
                              style: TextStyle(
                                fontSize: 15.h,
                                fontFamily: 'SUITE',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            subtitle: Text(
                              timeAgo(discussion.created_date),
                              style: TextStyle(
                                fontSize: 10.h,
                                fontFamily: 'SUITE',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  child: IconButton(
                                    key: ValueKey(likedDiscussions
                                        .contains(discussion.discussion_id)),
                                    icon: Icon(
                                      likedDiscussions.contains(
                                              discussion.discussion_id)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: likedDiscussions.contains(
                                              discussion.discussion_id)
                                          ? Colors.red
                                          : null,
                                    ),
                                    onPressed: () => toggleDiscussionLike(
                                        discussion.discussion_id),
                                  ),
                                ),
                                Text(
                                    '${discussionLikes[discussion.discussion_id] ?? 0}'),
                                IconButton(
                                  icon: Icon(isExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more),
                                  onPressed: () =>
                                      toggleExpand(discussion.discussion_id),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isExpanded)
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Column(
                              children: [
                                if (comments.containsKey(
                                        discussion.discussion_id) &&
                                    comments[discussion.discussion_id]!
                                        .isNotEmpty)
                                  ...comments[discussion.discussion_id]!
                                      .map((comment) => Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 3.h,
                                            ),
                                            child: ListTile(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                              tileColor: Color(0xFFF6F5FF),
                                              leading: Stack(
                                                children: [
                                                  Image.asset(
                                                    'assets/main/rabbit.png',
                                                    width: 42.h,
                                                    height: 42.h,
                                                  ),
                                                  Positioned(
                                                    top: 22.h,
                                                    left: 24.h,
                                                    child: FutureBuilder(
                                                      future: getbadge(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return SizedBox(
                                                            width: 0.h,
                                                          );
                                                        } else {
                                                          if (snapshot.data ==
                                                              null) {
                                                            return SizedBox(
                                                              width: 0.h,
                                                            );
                                                          } else if (snapshot
                                                                  .data! ==
                                                              "동") {
                                                            return Image.asset(
                                                              'assets/badge/bronze.png',
                                                              width: 20.h,
                                                              height: 20.h,
                                                            );
                                                          } else if (snapshot
                                                                  .data! ==
                                                              "은") {
                                                            return Image.asset(
                                                              'assets/badge/silver.png',
                                                              width: 20.h,
                                                              height: 20.h,
                                                            );
                                                          } else {
                                                            return Image.asset(
                                                              'assets/badge/gold.png',
                                                              width: 20.h,
                                                              height: 20.h,
                                                            );
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              title: Text(comment.content),
                                              subtitle: Text(timeAgo(
                                                  comment.created_date)),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  AnimatedSwitcher(
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    child: IconButton(
                                                      key: ValueKey(
                                                          likedComments
                                                              .contains(comment
                                                                  .comment_id)),
                                                      icon: Icon(
                                                        likedComments.contains(
                                                                comment
                                                                    .comment_id)
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border,
                                                        color: likedComments
                                                                .contains(comment
                                                                    .comment_id)
                                                            ? Colors.red
                                                            : null,
                                                      ),
                                                      onPressed: () =>
                                                          toggleCommentLike(
                                                              comment
                                                                  .comment_id),
                                                    ),
                                                  ),
                                                  Text(
                                                      '${commentLikes[comment.comment_id] ?? 0}'),
                                                ],
                                              ),
                                            ),
                                          )),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 30.w,
                                    top: 2.h,
                                  ),
                                  child: Container(
                                    width: 300.w,
                                    height: 46.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            minLines: 1,
                                            maxLines: null,
                                            controller: commentControllers[
                                                discussion.discussion_id],
                                            decoration: InputDecoration(
                                              hintText: "답글을 입력하세요",
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
                                        IconButton(
                                          icon: Icon(Icons.send),
                                          onPressed: () => postcomment(
                                              discussion.discussion_id),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 50.w,
                  top: 10.h,
                ),
                child: Container(
                  width: 300.w,
                  height: 46.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: TextField(
                          minLines: 1,
                          maxLines: null,
                          controller: discussionController,
                          decoration: InputDecoration(
                            hintText: "토론을 생성하세요",
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
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: postdiscussion,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
