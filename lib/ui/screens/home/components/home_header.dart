import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskify/ui/screens/home/home_view_model.dart';

class HomeHeader extends StatelessWidget {
  final HomeViewModel model;
  const HomeHeader({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF55847A),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 55.r,
                  backgroundColor: Colors.white,
                  backgroundImage: model.profileImageUrl != null
                      ? NetworkImage(model.profileImageUrl!)
                      : null,
                  child: model.profileImageUrl == null
                      ? Icon(
                          Icons.person,
                          color: const Color(0xFF55847A),
                          size: 50.sp,
                        )
                      : null,
                ),
              ),
              30.verticalSpace,
              Text(
                'Welcome ${model.userName}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.sp,
                ),
              ),
            ],
          ),
          Positioned(
            top: 10.h,
            right: 5.w,
            child: IconButton(
              onPressed: () => model.logout(context),
              icon: Icon(Icons.logout, color: Colors.white, size: 24.sp),
              tooltip: 'Logout',
            ),
          ),
        ],
      ),
    );
  }
}
