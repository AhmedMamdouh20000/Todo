import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';

class TaskEditTab extends StatefulWidget {
  static const String routeName = 'Task Edit';

  @override
  State<TaskEditTab> createState() => _TaskEditTabState();
}

class _TaskEditTabState extends State<TaskEditTab> {
  DateTime selectedDate = DateTime.now();

  DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  TextEditingController titleEditController = TextEditingController();

  TextEditingController descriptionEditController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: AppTheme.white,
        ),
        backgroundColor: AppTheme.primary,
        title: Text(
          'To Do List',
          style: TextStyle(
              fontSize: 22, color: AppTheme.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: AppTheme.primary,
            height: MediaQuery.of(context).size.height * 0.13,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.height * 0.78,
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Edit Task ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppTheme.backGroundColorDark),
                        ),
                        SizedBox(height: 16),
                        DefaultTextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Title Can not be empty';
                            } else
                              return null;
                          },
                          controller: titleEditController,
                          hintText: 'Enter Task Title',
                          maxLines: 1,
                        ),
                        SizedBox(height: 16),
                        DefaultTextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Description Can not be empty';
                            } else
                              return null;
                          },
                          controller: descriptionEditController,
                          hintText: 'Enter Task Description',
                          maxLines: 5,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Select Date',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.backGroundColorDark),
                        ),
                        SizedBox(height: 16),
                        InkWell(
                          onTap: () async {
                            DateTime? dateTime = await showDatePicker(
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                Duration(days: 365),
                              ),
                            );
                            if (dateTime != null) {
                              selectedDate = dateTime;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppTheme.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                dateFormat.format(selectedDate),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppTheme.backGroundColorDark,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32),
                        DefaultElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print('task added');
                              } else
                                return;
                            },
                            label: 'Submit'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
