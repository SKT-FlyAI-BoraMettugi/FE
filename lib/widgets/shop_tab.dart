import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:FE/widgets/elipse_painter.dart';

class ShopTab extends StatefulWidget {
  final int characterId;
  const ShopTab({
    super.key,
    required this.characterId,
  });

  @override
  State<ShopTab> createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> {
  List<String> clothes = [
    'assets/shop/heart.png',
    'assets/shop/music.png',
    'assets/shop/pixel_heart.png',
    'assets/shop/santa_hat.png',
    'assets/shop/space_heart.png',
    'assets/shop/star.png',
    'assets/shop/wizard_hat.png',
  ];
  int? selectedCloth;
  List<bool> isPurchased = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  List<bool> isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 35.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 23.w,
            ),
            Image.asset(
              'assets/main/coin.png',
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "3000",
              style: TextStyle(
                fontSize: 20.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 18.w,
            ),
            Image.asset(
              'assets/images/gold_key.png',
              width: 24.w,
              height: 24.h,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "0",
              style: TextStyle(
                fontSize: 20.h,
                fontFamily: 'SUITE',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 72.h,
        ),
        Stack(
          children: [
            CustomPaint(
              size: Size(393.w, 221.h),
              painter: EllipsePainter(),
            ),
            Positioned(
              top: 30.h,
              left: 99.w,
              child: Image.asset(
                'assets/character/${widget.characterId}.png',
                width: 195.w,
                height: 195.h,
              ),
            ),
            if (selectedCloth != null)
              Positioned(
                  top: 23.h,
                  left: 180.w,
                  child: Image.asset(
                    clothes[selectedCloth!],
                    width: 48.w,
                    height: 48.h,
                  ))
          ],
        ),
        SizedBox(
          height: 68.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 5.w,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 110.w,
                  height: 67.h,
                  decoration: BoxDecoration(
                    color: Color(0xFF01D4AD),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h, left: 40.w, right: 38.w),
                    child: Text(
                      "소품",
                      style: TextStyle(
                        fontSize: 15.h,
                        fontFamily: 'SUITE',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 32.h,
                  child: Container(
                    width: 383.w,
                    height: 321.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFF9F8FF),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 18.w,
                        right: 17.w,
                        top: 20.h,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 52.h,
                          mainAxisSpacing: 52.h,
                          childAspectRatio: 1,
                        ),
                        itemCount: clothes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              if (isPurchased[index] == false) {
                                setState(() {
                                  isPurchased[index] = true;
                                });
                              } else {
                                if (isSelected[index] == false) {
                                  setState(() {
                                    isSelected.fillRange(
                                        0, isSelected.length, false);
                                    isSelected[index] = true;
                                    selectedCloth = index;
                                  });
                                } else {
                                  setState(() {
                                    isSelected[index] = false;
                                    selectedCloth = null;
                                  });
                                }
                              }
                            },
                            child: Container(
                              width: 72.h,
                              height: 72.h,
                              decoration: BoxDecoration(
                                color: isPurchased[index]
                                    ? Color(0xFFFFFFFF)
                                    : Color(0xFFA6A6A6).withValues(
                                        alpha: 0.5,
                                      ),
                                border: Border.all(
                                    color: isSelected[index]
                                        ? Color(0xFF01D4AD)
                                        : Color(0xFFA6A6A6),
                                    width: isSelected[index] ? 3.w : 1.w),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: isPurchased[index]
                                  ? Padding(
                                      padding: EdgeInsets.all(1.h),
                                      child: Image.asset(
                                        clothes[index],
                                        width: 48.h,
                                        height: 48.h,
                                      ),
                                    )
                                  : Padding(
                                      padding: EdgeInsets.all(12.h),
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            clothes[index],
                                            width: 48.h,
                                            height: 48.h,
                                          ),
                                          Positioned(
                                            top: 5.h,
                                            left: 5.w,
                                            child: Image.asset(
                                              'assets/images/locker.png',
                                              width: 36.h,
                                              height: 36.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
