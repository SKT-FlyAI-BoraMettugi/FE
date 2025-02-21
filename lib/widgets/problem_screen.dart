import 'package:FE/widgets/discussion_tab.dart';
import 'package:FE/widgets/notification_screen.dart';
import 'package:FE/widgets/question_tab.dart';
import 'package:FE/widgets/result_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProblemScreen extends StatefulWidget {
  const ProblemScreen({super.key});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  final TextEditingController myanswer = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setImmersiveMode();
  }

  void _setImmersiveMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    myanswer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFEEEDF1),
        body: GestureDetector(
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
                height: 30.h,
              ),
              TabBar(
                tabs: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Text(
                      "문제",
                      style: TextStyle(
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Text(
                      "결과",
                      style: TextStyle(
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.w),
                    child: Text(
                      "토론",
                      style: TextStyle(
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
                indicatorColor: Color(0xFF01D4AD),
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                    vertical: 5.h,
                  ),
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      QuestionTab(),
                      ResultTab(),
                      DiscussionTab(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
