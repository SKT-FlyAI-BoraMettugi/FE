import 'package:FE/widgets/problem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Weekchallenge extends StatefulWidget {
  final int userId;
  final int character_id;
  const Weekchallenge({
    super.key,
    required this.character_id,
    required this.userId,
  });

  @override
  State<Weekchallenge> createState() => _WeekchallengeState();
}

class _WeekchallengeState extends State<Weekchallenge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textSizeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // 텍스트 크기가 커지는 애니메이션
    _textSizeAnimation = Tween<double>(begin: 20, end: 32).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // 화면이 위로 이동하는 애니메이션
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.3), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 24.h,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200.h,
          ),
          Hero(
            tag: "challenge",
            child: Image.asset(
              'assets/problem/week_challenge.png',
              width: 340.w,
              height: 200.h,
            ),
          ),
          SizedBox(height: 20),
          SlideTransition(
            position: _slideAnimation,
            child: AnimatedBuilder(
              animation: _textSizeAnimation,
              builder: (context, child) {
                return Text(
                  "한 주 챌린지에 오신 것을 환영합니다!",
                  style: TextStyle(
                    fontSize: _textSizeAnimation.value,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            child: Text(
              "한 주 챌린지는 매주 월요일에 갱신됩니다.\n한 주 챌린지의 점수가 전체 점수에 누적해서 반영됩니다.\n한 주 챌린지의 점수는 최초에 제출한 답변의 점수로 기록됩니다.",
              style: TextStyle(
                fontSize: 15.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w400,
                height: 2.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProblemScreen(
                  questionId: 17,
                  themeID: 1,
                  userId: widget.userId,
                  character_id: widget.character_id,
                ),
              ),
            ),
            child: Container(
              width: 120.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.green.shade300,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "시작하기",
                    style: TextStyle(
                      fontSize: 15.h,
                      fontFamily: 'SUITE',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
