import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../core/models/task.dart';
import '../core/theme/app_colors.dart';
import '../provider/tasks_provider.dart';

class TodoWidget extends StatelessWidget {
  TodoWidget({super.key, required this.task});
  Task task;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskProvider>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 20.0.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Slidable(
            // Specify a key if the Slidable is dismissible.
            key: ValueKey(0),
      
            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: ScrollMotion(),
      
              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {}),
      
              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: (sa) {
                      provider.removeTask(task);
                  },
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Share',
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.h),
              color: Theme.of(context).colorScheme.onSecondary,
              height: 100.h,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 3.w,
                    height: double.infinity,
                    color: task.isCompleted ? AppColors.green : AppColors.primary,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.s,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title),
                      Row(children: [
                        Text(task.description),
                      ])
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10)),
                    width: 70.w,
                    height: 35.h,
                    child: Icon(Icons.check, color: Colors.white),
                    // color: AppColors.primary,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
