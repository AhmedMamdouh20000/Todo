import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/tabs/tasks/task_edit_tab.dart';
import 'package:todo/tabs/tasks/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  bool shouldGetTasks = true;

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    if (shouldGetTasks) {
      tasksProvider.getTasks(
        Provider.of<UserProvider>(context, listen: false).currentUser!.id,
      );
      shouldGetTasks = false;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 35),
            width: double.infinity,
            color: AppTheme.primary,
            height: MediaQuery.of(context).size.height * 0.09,
            child: Text(
              'To Do List',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppTheme.white,
                    fontSize: 22,
                  ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              EasyInfiniteDateTimeLine(
                lastDate: DateTime.now().add(
                  const Duration(days: 30),
                ),
                firstDate: DateTime.now(),
                focusDate: tasksProvider.selectedDate,
                onDateChange: (selectedDate) {
                  tasksProvider.changeSelectedDate(selectedDate);
                  tasksProvider.getTasks(
                    Provider.of<UserProvider>(context, listen: false)
                        .currentUser!
                        .id,
                  );
                },
                showTimelineHeader: false,
                activeColor: AppTheme.white,
                dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayNumDayStr,
                  todayStyle: DayStyle(
                    monthStrStyle: const TextStyle(color: Colors.transparent),
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
                    dayStrStyle:
                        Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: AppTheme.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                    dayNumStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  inactiveDayStyle: DayStyle(
                    dayStrStyle:
                        Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppTheme.white),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  itemBuilder: (_, index) => TaskItem(tasksProvider.tasks[index]),
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
