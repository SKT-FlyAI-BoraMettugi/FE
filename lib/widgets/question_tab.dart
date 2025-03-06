import 'dart:convert';

import 'package:FE/widgets/getquestion_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class QuestionTab extends StatefulWidget {
  final int questionID;
  final int userId;
  const QuestionTab(
      {super.key, required this.questionID, required this.userId});

  @override
  State<QuestionTab> createState() => _QuestionTabState();
}

class _QuestionTabState extends State<QuestionTab> {
  final TextEditingController myanswer = TextEditingController();

  Future<void> answerSubmit(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final response = await http.post(
        Uri.parse(
          'http://nolly.ap-northeast-2.elasticbeanstalk.com/answer/${widget.userId}/${widget.questionID}',
        ),
      );

      // 다이얼로그 닫기 (현재 context가 유효한지 확인)
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      // 응답 결과에 따라 알림 표시 (context 사용 전에 mounted 확인)
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "알림",
              style: TextStyle(
                fontSize: 20.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              response.statusCode == 200 ? "문제 출제 완료" : "응답 오류",
              style: TextStyle(
                fontSize: 15.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "확인",
                  style: TextStyle(
                    fontSize: 15.h,
                    fontFamily: 'SUITE',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // 네트워크 오류 발생 시, 다이얼로그 닫기 (context가 mounted인지 확인)
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "오류",
              style: TextStyle(
                fontSize: 20.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              "네트워크 오류: $e",
              style: TextStyle(
                fontSize: 15.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w400,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "닫기",
                  style: TextStyle(
                    fontSize: 15.h,
                    fontFamily: 'SUITE',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<GetquestionModel> question() async {
    final response = await http.get(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/question/${widget.questionID}'));
    if (response.statusCode == 200) {
      final String decodedbody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> questions = jsonDecode(decodedbody);
      GetquestionModel question = GetquestionModel.fromJson(questions);
      return question;
    }
    throw Error();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 383.w,
            decoration: BoxDecoration(
              color: Color(0xFFF9F8FF),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: FutureBuilder(
              future: question(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "문제 불러오기를 실패했습니다.",
                      style: TextStyle(
                        fontSize: 20.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "난이도 : ${snapshot.data!.level}",
                              style: TextStyle(
                                fontSize: 15.h,
                                fontFamily: 'SUITE',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Image.asset(
                        'assets/problem/${snapshot.data!.image_url}',
                        width: 330.w,
                        height: 180.h,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.h,
                        ),
                        child: SizedBox(
                          width: 350.w,
                          child: Text(
                            snapshot.data!.description,
                            style: TextStyle(
                              fontSize: 15.h,
                              fontFamily: 'SUITE',
                              fontWeight: FontWeight.w400,
                              height: 3.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
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
                style: TextStyle(),
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
          if (myanswer.text.isNotEmpty == true)
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
                        content: Text("답변 : ${myanswer.text}\n답변을 제출하시겠습니까?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "알림",
                                        ),
                                        content: Text("답변 제출 완료"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                myanswer.clear();
                                              },
                                              child: Text("확인")),
                                        ],
                                      );
                                    });
                              },
                              child: Text("제출")),
                        ],
                      );
                    });
                DefaultTabController.of(context).animateTo(1);
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
            )
          else
            Container(
              width: 327.w,
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Color(0xFFA6A6A6),
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
          SizedBox(
            height: 14.h,
          ),
          Builder(
            builder: (context) {
              double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
              return SizedBox(height: keyboardHeight);
            },
          ),
        ],
      ),
    );
  }
}
