import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../core/models/task.dart';
import '../core/networking/firebase_api.dart';
import '../core/widgets/app_text_filed.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 600.h,
        margin: EdgeInsets.all(12.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.addTask,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 42.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTextFormField(
                  controller: titleController,
                  hintText: AppLocalizations.of(context)!.title,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return AppLocalizations.of(context)!.titleRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 52.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTextFormField(
                  controller: descriptionController,
                  hintText: AppLocalizations.of(context)!.description,
                  validator: (text) {
                    if (text!.isEmpty) {
                      return AppLocalizations.of(context)!.descriptionRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.date,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                GestureDetector(
                  onTap: () async {
                    selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        ) ??
                        DateTime.now();
                    setState(() {});
                  },
                  child: Text(
                    '${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
                // Spacer(),\
                SizedBox(
                  height: 152.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final User? user = FirebaseAuth.instance.currentUser;

                      if (user != null) {
                        FirebaseApi.addTaskToFirebase(Task(
                                '',
                                user.uid,
                                titleController.text,
                                descriptionController.text,
                                selectedDate,
                                false))
                            .then((value) {
                          if (kDebugMode) {
                            print('here we are');
                          }
                          Navigator.of(context).pop([
                            titleController.text,
                            descriptionController.text,
                            selectedDate
                          ]);
                        });
                      }
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.add),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
