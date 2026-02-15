import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/core/constants/enums/priority.dart';
import 'package:taskify/ui/screens/add_task/add_task_view.dart';
import 'package:taskify/ui/screens/home/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, model, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF55847A),
            onPressed: () async {
              final result = await showModalBottomSheet<bool>(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => const AddTaskView(),
              );

              if (result == true) {
                model.refreshTasks();
              }
            },
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(model, context),
                10.verticalSpace,
                _buildSectionTitle(),
                7.verticalSpace,
                _buildTaskList(model),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(HomeViewModel model, BuildContext context) {
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

  Widget _buildSectionTitle() {
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

  Widget _buildTaskList(HomeViewModel model) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: model.onRefresh,
        color: const Color(0xFF55847A),
        backgroundColor: Colors.white,
        child: model.tasks.isEmpty
            ? _buildEmptyState()
            : _buildTaskListView(model),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task_alt, size: 100.sp, color: Colors.grey[300]),
              20.verticalSpace,
              Text(
                'No tasks yet!',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              10.verticalSpace,
              Text(
                'Pull down to refresh or tap + to add a task',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskListView(HomeViewModel model) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: model.tasks.length,
      itemBuilder: (context, index) {
        final task = model.tasks[index];
        return _buildTaskCard(context, model, task);
      },
    );
  }

  Widget _buildTaskCard(BuildContext context, HomeViewModel model, task) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: _buildDeleteBackground(),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Task'),
            content: Text('Delete "${task.title}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        model.deleteTask(context, task);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => model.toggleIsCompleted(task),
                child: _buildCheckbox(task),
              ),
              15.horizontalSpace,
              _buildTaskContent(task),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.w),
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delete, color: Colors.white, size: 32.sp),
          4.verticalSpace,
          Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox(task) {
    return Container(
      width: 24.w,
      height: 24.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: task.isCompleted ? Colors.green : Colors.grey.shade300,
      ),
      child: Icon(Icons.check, size: 16.sp, color: Colors.white),
    );
  }

  Widget _buildTaskContent(task) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
              10.horizontalSpace,
              _buildPriorityBadge(task.priority),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            task.description,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              decoration: task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            task.time,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBadge(Priority priority) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: priority.color,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        priority.displayName.toUpperCase(),
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
