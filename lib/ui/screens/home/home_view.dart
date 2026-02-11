import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/ui/screens/home/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                header(model, context),
                10.verticalSpace,
                text(),
                7.verticalSpace,
                taskList(model),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget header(HomeViewModel model, context) {
    return Container(
      height: 220.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF55847A),
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
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF55847A),
                    size: 50.sp,
                  ),
                ),
              ),
              30.verticalSpace,
              Text(
                'Welcome Shayan',
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
              onPressed: () {
                model.logout(context);
              },
              icon: Icon(Icons.logout, color: Colors.white, size: 24.sp),
              tooltip: 'Logout',
            ),
          ),
        ],
      ),
    );
  }

  Widget text() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Todo Tasks',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.sp,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget taskList(HomeViewModel model) {
    return Expanded(
      child: ListView.builder(
        itemCount: model.tasks.length,
        itemBuilder: (context, index) {
          final task = model.tasks[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 20.h,
                horizontal: 16.w,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      model.toggleIsCompleted(task);
                    },
                    child: checkBox(task),
                  ),
                  15.horizontalSpace,
                  titleAndDescription(task),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget checkBox(task) {
    return Container(
      width: 24.w,
      height: 24.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: task.isCompleted ? Colors.green : Colors.grey.shade300,
      ),
      child: task.isCompleted
          ? Icon(Icons.check, size: 16.sp, color: Colors.white)
          : Icon(Icons.check, size: 16.sp, color: Colors.white),
    );
  }

  Widget titleAndDescription(task) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
              100.horizontalSpace,
              // Priority badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: getPriorityColor(task.priority),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  task.priority,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            task.description,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.yellow;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
