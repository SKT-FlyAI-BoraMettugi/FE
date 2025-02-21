import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionTab extends StatefulWidget {
  const QuestionTab({
    super.key,
  });

  @override
  State<QuestionTab> createState() => _QuestionTabState();
}

class _QuestionTabState extends State<QuestionTab> {
  final TextEditingController myanswer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 383.w,
            height: 600.h,
            decoration: BoxDecoration(
              color: Color(0xFFF9F8FF),
              borderRadius: BorderRadius.circular(20.r),
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
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
