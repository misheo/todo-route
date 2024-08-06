import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/provider/settings_provider.dart';
import 'package:todo/screens/tasks_screen.dart';

import '../widgets/add_task_sheet.dart';
import 'setting/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = const [
    TasksScreen(),
    SettingScreen(),
  ];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 22.0.w),
          child: Text(AppLocalizations.of(context)!.appTitle),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100.h,
                color: AppColors.primary,
              ),
              _pages[_index]
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { print('here we are ') ; 
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTaskSheet(),
          );} ,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // height: 66.h,
        padding: const EdgeInsets.all(0),
        clipBehavior: Clip.hardEdge,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: BottomNavigationBar(
          elevation: 0,
          enableFeedback: true,
          // iconSize: 21.sp,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          currentIndex: _index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
