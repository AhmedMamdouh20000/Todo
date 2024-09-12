import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Logout',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 25,
                        )),
                IconButton(
                  onPressed: () {
                    FirebaseFunctions.logout();
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routeName);
                    Provider.of<TasksProvider>(context, listen: false)
                        .tasks
                        .clear();
                    Provider.of<UserProvider>(context, listen: false)
                        .updatUser(null);
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
