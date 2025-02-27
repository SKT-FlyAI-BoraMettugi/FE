import 'dart:convert';

import 'package:FE/widgets/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class ExamTab extends StatefulWidget {
  final int userId;
  const ExamTab({
    super.key,
    required this.userId,
  });

  @override
  State<ExamTab> createState() => _ExamTabState();
}

class _ExamTabState extends State<ExamTab> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController answer = TextEditingController();

  late FocusNode focusNodet;
  late FocusNode focusNodeq;
  late FocusNode focusNodea;

  // 문제를 DB로 보낸다.
  Future<void> submit(BuildContext context) async {
    // 로딩 다이얼로그 표시
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
          'http://nolly.ap-northeast-2.elasticbeanstalk.com/question/${widget.userId}',
        ),
        body: utf8.encode(
          jsonEncode({
            'title': title.text,
            'description': description.text,
            'answer': answer.text,
          }),
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
              response.statusCode == 200
                  ? "문제 출제 완료\n관리자의 검토 후에 문제가 등록됩니다."
                  : "응답 오류",
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

  // 텍스트 상자를 초기화한다.
  void clearTextFields() {
    title.clear();
    description.clear();
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
    description.dispose();
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
                                  controller: description,
                                  minLines: 1,
                                  maxLines: null,
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
                                  minLines: 1,
                                  maxLines: null,
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
                      if ((title.text.isNotEmpty &&
                              description.text.isNotEmpty &&
                              answer.text.isNotEmpty) ==
                          true)
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.immersiveSticky);
                            submit(context);
                            clearTextFields();
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
                        )
                      else
                        Container(
                          width: 327.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFA6A6A6),
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
