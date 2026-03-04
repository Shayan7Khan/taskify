import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:taskify/ui/screens/add_task/add_task_view_model.dart';
import 'package:taskify/ui/screens/add_task/components/add_task_fields.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTaskViewModel(),
      child: Consumer<AddTaskViewModel>(
        builder: (context, model, child) => Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 20.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: SingleChildScrollView(
            //main content
            child: AddTaskFields(model: model),
          ),
        ),
      ),
    );
  }
}
