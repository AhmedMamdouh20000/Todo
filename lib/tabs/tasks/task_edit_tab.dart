import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskEditTab extends StatefulWidget {
  static const String routeName = 'Task Edit';

  const TaskEditTab({super.key});

  @override
  State<TaskEditTab> createState() => _TaskEditTabState();
}

class _TaskEditTabState extends State<TaskEditTab> {
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  TextEditingController titleEditController = TextEditingController();
  TextEditingController descriptionEditController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TaskModel? task ;
  @override
  Widget build(BuildContext context) {
    if(task == null){
      task = ModalRoute.of(context)!.settings.arguments as TaskModel;
      selectedDate =task!.date;
      titleEditController.text = task!.title;
      descriptionEditController.text = task!.description;
    }
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Edit Task ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppTheme.backGroundColorDark),
                        ),
                        const SizedBox(height: 16),
                        DefaultTextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Title Can not be empty';
                            } else {
                              return null;
                            }
                          },
                          controller: titleEditController,
                          hintText: 'Enter Task Title',
                          maxLines: 1,
                        ),
                        const SizedBox(height: 16),
                        DefaultTextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Description Can not be empty';
                            } else {
                              return null;
                            }
                          },
                          controller: descriptionEditController,
                          hintText: 'Enter Task Description',
                          maxLines: 5,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Select Date',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.backGroundColorDark),
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: () async {
                            DateTime? dateTime = await showDatePicker(
                              initialEntryMode:
                                  DatePickerEntryMode.calendarOnly,
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
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
                        const SizedBox(height: 32),
                        DefaultElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              updateTask();
                            } else {
                              return;
                            }
                          },
                          label: 'Save Changes',
                        ),
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
  void updateTask() {
    task!.title =titleEditController.text ;
    task!.description =descriptionEditController.text;
    task!.date = selectedDate ;
    FirebaseFunctions.editTask(
      task!,
      Provider.of<UserProvider>(context, listen: false).currentUser!.id,
    ).then(
          (_) {
        Navigator.of(context).pop();
        Provider.of<TasksProvider>(context, listen: false).getTasks(
          Provider.of<UserProvider>(context, listen: false).currentUser!.id,
        );
        Fluttertoast.showToast(
          msg: "Task Edit Successfully !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
    ).catchError(
          (_) {
        Fluttertoast.showToast(
            msg: "Something went wrong !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
  }
}
