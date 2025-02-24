import 'dart:convert';

import 'package:FE/widgets/elipse_painter.dart';
import 'package:FE/widgets/exam_tab.dart';
import 'package:FE/widgets/getranking_model.dart';
import 'package:FE/widgets/getuser_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/loading_screen.dart';
import 'package:FE/widgets/main_tab.dart';
import 'package:FE/widgets/mypage_tab.dart';
import 'package:FE/widgets/shop_tab.dart';
import 'package:FE/widgets/theme_tab.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoadingScreen(),
        );
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<Map<String, dynamic>>? totalData;
  // 페이지 이동시에도 bottomnavigationbar 유지
  final List<GlobalKey<NavigatorState>> _navigatorKeys =
      List.generate(5, (index) => GlobalKey<NavigatorState>());
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    }
  }

  Future<bool> _onWillPop() async {
    // 현재 선택된 탭의 Navigator 가져오기
    final NavigatorState? currentNavigator =
        _navigatorKeys[_currentIndex].currentState;

    // 현재 탭의 Navigator가 존재하고, 뒤로 갈 페이지가 있으면 pop 실행
    if (currentNavigator != null && currentNavigator.canPop()) {
      currentNavigator.pop();
      FocusScope.of(context).unfocus();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      return false; // 기본 뒤로 가기 동작을 막음
    }

    // 첫 번째 페이지인 경우 종료 다이얼로그 표시
    bool? exitApp = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "앱 종료",
          style: TextStyle(
            fontSize: 20.h,
            fontFamily: 'SUITE',
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          "앱을 종료하시겠습니까?",
          style: TextStyle(
            fontSize: 15.h,
            fontFamily: 'SUITE',
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              "아니요",
              style: TextStyle(
                fontSize: 15.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              "예",
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
    return exitApp ?? false;
  }

  Future<GetuserModel> userinfo() async {
    final response = await http.get(
        Uri.parse('http://nolly.ap-northeast-2.elasticbeanstalk.com/user/1'));
    if (response.statusCode == 200) {
      final decodedbody = utf8.decode(response.bodyBytes);
      final Map<String, dynamic> infos = jsonDecode(decodedbody);
      GetuserModel info = GetuserModel.fromJson(infos);
      return info;
    }
    throw Error();
  }

  Future<GetrankingModel> userrank() async {
    final response = await http.get(Uri.parse(
        'http://nolly.ap-northeast-2.elasticbeanstalk.com/ranking/1'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> ranks = jsonDecode(response.body);
      GetrankingModel rank = GetrankingModel.fromJson(ranks);
      return rank;
    }
    throw Error();
  }

  Future<Map<String, dynamic>> fetchData() async {
    final responses = await Future.wait([
      userinfo(),
      userrank(),
    ]);

    return {
      'info': responses[0],
      'rank': responses[1],
    };
  }

  @override
  void initState() {
    super.initState();
    totalData = fetchData();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
          },
          child: FutureBuilder(
            future: totalData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: Color(0xFFEEEDF1),
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Scaffold(
                  backgroundColor: Color(0xFFEEEDF1),
                  body: Center(
                    child: Text(
                      "정보 불러오기에 실패했습니다.",
                      style: TextStyle(
                        fontSize: 20.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              } else {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Color(0xFFEEEDF1),
                  body: Stack(
                    children: List.generate(5, (index) {
                      return Offstage(
                        offstage: _currentIndex != index,
                        child: Navigator(
                          key: _navigatorKeys[index],
                          onGenerateRoute: (routeSettings) {
                            return MaterialPageRoute(
                              builder: (context) => _getScreen(
                                rank: snapshot.data!['rank'].rank,
                                score: snapshot.data!['info'].score,
                                nickname: snapshot.data!['info'].nickname,
                                index: index,
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                  bottomNavigationBar: SizedBox(
                    height: 74.h,
                    child: BottomNavigationBar(
                      backgroundColor: Colors.white,
                      currentIndex: _currentIndex,
                      onTap: _onTabTapped,
                      selectedItemColor: Colors.black,
                      unselectedItemColor: Color(0xFFA6A6A6),
                      selectedLabelStyle: TextStyle(
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFA6A6A6),
                      ),
                      type: BottomNavigationBarType.fixed,
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.storefront, size: 36.h),
                          label: "메인",
                        ),
                        BottomNavigationBarItem(
                          icon:
                              Icon(Icons.assistant_photo_outlined, size: 36.h),
                          label: "테마",
                        ),
                        BottomNavigationBarItem(
                          icon:
                              Icon(Icons.design_services_outlined, size: 36.h),
                          label: "출제",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.auto_fix_high_outlined, size: 36.h),
                          label: "상점",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.menu, size: 36.h),
                          label: "마이 페이지",
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _getScreen({
    required int rank,
    required int score,
    required String nickname,
    required int index,
  }) {
    switch (index) {
      case 0:
        return GestureDetector(
          onDoubleTap: () {
            setState(() {
              totalData = fetchData();
            });
          },
          child: MainTab(
            userrank: rank,
            score: score,
            nickname: nickname,
          ),
        );
      case 1:
        return ThemeTab();
      case 2:
        return ExamTab();
      case 3:
        return ShopTab();
      case 4:
        return MyPageTab(
          nickname: nickname,
        );
      default:
        return Center(child: Text("Error"));
    }
  }
}
