import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController describtionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add New Task',
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
                  }else
                    return null ;
                },
                controller: titleController,
                hintText: 'Enter Task Title',
                maxLines: 1,
              ),
              SizedBox(height: 16),
              DefaultTextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description Can not be empty';
                  }else
                    return null ;
                },
                controller: describtionController,
                hintText: 'Enter Task Description',
                maxLines: 5,
              ),
              SizedBox(height: 16),
              Text(
                'Select Date',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppTheme.backGroundColorDark),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  DateTime? dateTime = await showDatePicker(
                    initialEntryMode: DatePickerEntryMode.calendarOnly,
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
                child: Text(
                  dateFormat.format(selectedDate),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.backGroundColorDark,
                      ),
                ),
              ),
              SizedBox(height: 32),
              DefaultElevatedButton(onPressed: () {
                if(formKey.currentState!.validate()){
                  print('task added');
                }else return;
              }, label: 'Submit'),
            ],
          ),
        ),
      ),
    );
  }
}
