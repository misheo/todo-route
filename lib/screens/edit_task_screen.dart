import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/tasks_provider.dart';

import '../core/models/task.dart';
import '../core/widgets/app_text_filed.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    selectedDate = widget.task.date;
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
    super.initState();
  }

  onTap() {
    if (formKey.currentState!.validate()) {
      print('We are here' ); 
      widget.task.title = titleController.text;
      widget.task.description = descriptionController.text;
      widget.task.date = selectedDate;
      Provider.of<TaskProvider>(context, listen: false).updateTask(widget.task);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.editTask,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 18.0.w , vertical: 20.h),
            child: Column(children: [
             
         
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
                        lastDate: DateTime.now().add(const Duration(days: 365)),
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
                onPressed: onTap,
                child: Text(AppLocalizations.of(context)!.edit),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
