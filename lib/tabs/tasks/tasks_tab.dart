import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/task_edit_tab.dart';
import 'package:todo/tabs/tasks/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 35),
            child: Text(
              'To Do List',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppTheme.white,
                    fontSize: 22,
                  ),
            ),
            width: double.infinity,
            color: AppTheme.primary,
            height: MediaQuery.of(context).size.height * 0.09,
          ),
          SizedBox(
            height: 8,
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              EasyInfiniteDateTimeLine(
                lastDate: DateTime.now().add(
                  Duration(days: 30),
                ),
                firstDate: DateTime.now(),
                focusDate: tasksProvider.selectedDate,
                onDateChange: (selectedDate) {
                  tasksProvider.changeSelectedDate(selectedDate);
                  tasksProvider.getTasks();
                },
                showTimelineHeader: false,
                activeColor: AppTheme.white,
                dayProps: EasyDayProps(
                  todayStyle: DayStyle(
                    monthStrStyle: TextStyle(color: Colors.transparent),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppTheme.white),
                  ),
                  height: 100,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    dayStrStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: AppTheme.primary),
                    monthStrStyle: TextStyle(color: Colors.transparent),
                    dayNumStyle: Theme.of(context).textTheme.titleMedium,
                  ),
                  inactiveDayStyle: DayStyle(
                    dayStrStyle: Theme.of(context).textTheme.titleSmall,
                    monthStrStyle: TextStyle(color: Colors.transparent,),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppTheme.white),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(TaskEditTab.routeName);
                      },
                      child: TaskItem(tasksProvider.tasks[index])),
                  itemCount: tasksProvider.tasks.length,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
