import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/tasks/add_task_bottom_sheet.dart';
import 'package:todo/tabs/tasks/task_edit_tab.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatefulWidget {
  const TaskItem(this.task, {super.key});

  final TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  DateTime selectedDate = DateTime.now();
  DateFormat dateFormat = DateFormat('EEE , MMM d ');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              onPressed: (_) {
                FirebaseFunctions.deleteTaskFromFirestore(
                  widget.task.id,
                  Provider.of<UserProvider>(context, listen: false)
                      .currentUser!
                      .id,
                ).then((_) {
                  Provider.of<TasksProvider>(context, listen: false).getTasks(
                    Provider.of<UserProvider>(context, listen: false)
                        .currentUser!
                        .id,
                  );
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
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              TaskEditTab.routeName,
              arguments: widget.task,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(end: 8),
                  height: 62,
                  width: 4,
                  color:
                      widget.task.isDone! ? AppTheme.green : AppTheme.primary,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: widget.task.isDone!
                                ? AppTheme.green
                                : AppTheme.primary,
                          ),
                    ),
                    Text(
                      widget.task.description,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 15,
                          ),
                    ),
                    // Text(
                    //   dateFormat.format(selectedDate),
                    //   style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    //         color: AppTheme.backGroundColorDark,
                    //         fontSize: 12,
                    //       ),
                    // ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    var authProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    FirebaseFunctions.editIsDone(
                        widget.task, authProvider.currentUser?.id ?? "");
                    widget.task.isDone = !widget.task.isDone!;
                    setState(() {});
                  },
                  child: widget.task.isDone!
                      ? Text(
                          "Done!",
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: AppTheme.green,
                                  ),
                        )
                      : Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 75,
                          child: const Icon(
                            color: Colors.white,
                            Icons.check,
                            size: 33,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
