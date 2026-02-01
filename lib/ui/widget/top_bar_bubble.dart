import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopBarBubble extends StatelessWidget {
  const TopBarBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -50,
          left: -50,
          child: Container(
            width: 170.w,
            height: 170.h,
            decoration: BoxDecoration(
              color: Color(0xFF7FAE9E),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: -30,
          left: -30,
          child: Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: Color(0xFF55847A),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
