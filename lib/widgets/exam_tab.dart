import 'dart:convert';

import 'package:FE/widgets/exam_model.dart';
import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class ExamTab extends StatefulWidget {
  const ExamTab({super.key});

  @override
  State<ExamTab> createState() => _ExamTabState();
}

class _ExamTabState extends State<ExamTab> {
  final TextEditingController title = TextEditingController();
  final TextEditingController question = TextEditingController();
  final TextEditingController answer = TextEditingController();

  late FocusNode focusNodet;
  late FocusNode focusNodeq;
  late FocusNode focusNodea;

  // 문제를 DB로 보낸다.
  Future<String> submit(int userId) async {
    final response =
        await http.post(Uri.parse('http://boramettugi.com/question/$userId'),
            body: jsonEncode(<String, String>{
              'title': title.text,
              'question': question.text,
              'answer': answer.text,
            }));
    if (response.statusCode == 201) {
      final Map<String, dynamic> exam = jsonDecode(response.body);
      return ExamModel.fromJson(exam).message;
    } else {
      throw Exception('문제 출제에 오류가 발생했습니다. 다시 시도해주세요.');
    }
  }

  // 텍스트 상자를 초기화한다.
  void clearTextFields() {
    title.clear();
    question.clear();
    answer.clear();
  }

  @override
  void initState() {
    super.initState();
    focusNodet = FocusNode();
    focusNodeq = FocusNode();
    focusNodea = FocusNode();
  }

  @override
  void dispose() {
    // TextEditingController를 사용한 후에는 메모리 해제를 위해 dispose() 호출
    title.dispose();
    question.dispose();
    answer.dispose();
    // 키보드 포커스 해제
    focusNodet.dispose();
    focusNodeq.dispose();
    focusNodea.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      },
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
                        builder: (context) => NotificationScreen()),
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
            height: 18.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "문제 출제",
                style: TextStyle(
                  fontSize: 20.h,
                  fontFamily: 'SUITE',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14.h,
          ),
          Container(
            width: 383.w,
            height: 1.h,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
            ),
          ),
          SizedBox(
            width: 393.w,
            height: 657.h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Container(
                    width: 377.w,
                    height: 564.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F8FF),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 15.w,
                            ),
                            Text(
                              "제목",
                              style: TextStyle(
                                fontSize: 20.h,
                                fontFamily: 'SUITE',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 14.w,
                            ),
                            Container(
                              width: 351.w,
                              height: 46.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: TextField(
                                  focusNode: focusNodet,
                                  controller: title,
                                  showCursor: true,
                                  style: TextStyle(
                                    fontSize: 15.h,
                                    fontFamily: 'SUITE',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '제목을 입력하세요.',
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
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 14.w,
                            ),
                            Text(
                              "내용",
                              style: TextStyle(
                                fontSize: 20.h,
                                fontFamily: 'SUITE',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 14.w,
                            ),
                            Container(
                              width: 351.w,
                              height: 178.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: TextField(
                                  focusNode: focusNodeq,
                                  controller: question,
                                  maxLines: 10,
                                  showCursor: true,
                                  style: TextStyle(
                                    fontSize: 15.h,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SUITE',
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '내용을 입력하세요.',
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
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 14.w,
                            ),
                            Text(
                              "답",
                              style: TextStyle(
                                fontSize: 20.h,
                                fontFamily: 'SUITE',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 14.w,
                            ),
                            Container(
                              width: 351.w,
                              height: 175.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                ),
                                child: TextField(
                                  focusNode: focusNodea,
                                  controller: answer,
                                  maxLines: 10,
                                  showCursor: true,
                                  style: TextStyle(
                                    fontFamily: 'SUITE',
                                    fontSize: 15.h,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '답을 입력하세요.',
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
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 33.w,
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
                                      "제목 : ${title.text}\n질문 : ${question.text}\n답 : ${answer.text}"),
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
                                                  content: Text("문제 출제 완료"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          clearTextFields();
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
                        },
                        child: Container(
                          width: 327.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Color(0xFF01D4AD),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "출제하기",
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
                    ],
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
        ],
      ),
    );
  }
}
