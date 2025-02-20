import 'dart:async';
import 'package:FE/widgets/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 420.h,
                  ),
                  Text("Hello")
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
