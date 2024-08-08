import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/networking/firebase_api.dart';

import '../core/models/task.dart';
import '../core/theme/app_colors.dart';
import '../provider/tasks_provider.dart';
import '../widgets/todo_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();
  @override
  void initState() {
    Provider.of<TaskProvider>(context, listen: false).getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TaskProvider>(context);
    return Column(
      children: [
        EasyDateTimeLine(
          activeColor: AppColors.primary,
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.

            provider.changeSelectDate(selectedDate);
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps: const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            inactiveDayStyle: DayStyle(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff3371FF),
                    Color(0xff8426D6),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 500.h,
          child: ListView.builder(
            // shrinkWrap: true,
            
            itemCount: provider.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TodoWidget(
                task: provider.tasks[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
