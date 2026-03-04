import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/ui/screens/add_task/add_task_view.dart';
import 'package:taskify/ui/screens/home/components/home_header.dart';
import 'package:taskify/ui/screens/home/components/home_section_title.dart';
import 'package:taskify/ui/screens/home/components/home_task_list.dart';
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
                //header
                HomeHeader(model: model),
                10.verticalSpace,
                //title
                HomeSectionTitle(),
                7.verticalSpace,
                //content
                HomeTaskList(model: model),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
