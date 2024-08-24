import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatefulWidget {
  TaskItem(this.task);

  TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFunctions.deleteTaskFromFirestore(widget.task.id)
                    .timeout(
                    Duration(
                          microseconds: 500,
                        ),
                    onTimeout: () {
                      Provider.of<TasksProvider>(context,listen: false).getTasks();
                  Fluttertoast.showToast(
                    msg: "Task deleted successfully !",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: AppTheme.green,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  setState(() {});
                }).catchError(
                  (error) {
                    Fluttertoast.showToast(
                      msg: "Something went wrong !",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    print(error);
                  },
                );
              },
              backgroundColor: AppTheme.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(
                  end: 8,
                ),
                height: 62,
                width: 4,
                color: AppTheme.primary,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    widget.task.description,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                width: 75,
                child: IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 32,
                  ),
                  onPressed: () {},
                  color: AppTheme.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
