import 'package:flutter/cupertino.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class TasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<TaskModel> tasks = List.generate(
      10,
      (index) => TaskModel(
        title: 'Task #${index + 1}',
        description: 'description #${index + 1}',
        dateTime: DateTime.now(),
      ),
    );
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          EasyInfiniteDateTimeLine(
            lastDate: DateTime.now().add(
              Duration(days: 30),
            ),
            firstDate: DateTime.now(),
            focusDate: DateTime.now(),
            showTimelineHeader: false,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                top: 20,
              ),
              itemBuilder: (_, index) => TaskItem(tasks[index]),
              itemCount: tasks.length,
            ),
          ),
        ],
      ),
    );
  }
}
