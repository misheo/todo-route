import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../core/models/task.dart';
import '../core/theme/app_colors.dart';
import '../provider/tasks_provider.dart';
import '../screens/edit_task_screen.dart';

// ignore: must_be_immutable
class TodoWidget extends StatefulWidget {
  TodoWidget({super.key, required this.task});
  Task task;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
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
            key: const ValueKey(0),
      
            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),
      
              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {}),
      
              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: (sa) {
                      provider.removeTask(widget.task);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditTaskScreen(task: widget.task),
                      ),
                    ); 
                  },
                  backgroundColor:const Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: 'Edit',
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
                    color: widget.task.isCompleted ? AppColors.green : AppColors.primary,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.s,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.task.title),
                      Row(children: [
                        Text(widget.task.description),
                      ])
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.task.isCompleted = !widget.task.isCompleted;
                      provider.updateTask(widget.task);
                      setState(() {
                        
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10)),
                      width: 70.w,
                      height: 35.h,
                      child: const Icon(Icons.check, color: Colors.white),
                      // color: AppColors.primary,
                    ),
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
