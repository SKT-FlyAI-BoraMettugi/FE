import 'package:FE/widgets/exam_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/loading_screen.dart';
import 'package:FE/widgets/main_tab.dart';
import 'package:FE/widgets/mypage_tab.dart';
import 'package:FE/widgets/shop_tab.dart';
import 'package:FE/widgets/theme_tab.dart';

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
        title: const Text("앱 종료"),
        content: const Text("앱을 종료하시겠습니까?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("아니요"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("예"),
          ),
        ],
      ),
    );
    return exitApp ?? false;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
          child: Scaffold(
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
                        builder: (context) => _getScreen(index),
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
                    icon: Icon(Icons.assistant_photo_outlined, size: 36.h),
                    label: "테마",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.design_services_outlined, size: 36.h),
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
          ),
        ),
      ),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return MainTab();
      case 1:
        return ThemeTab();
      case 2:
        return ExamTab();
      case 3:
        return ShopTab();
      case 4:
        return MyPageTab();
      default:
        return Center(child: Text("Error"));
    }
  }
}
