import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seven_habit_rule/modules/home/widgets/task_tile.dart';
import 'package:seven_habit_rule/modules/shared/models/task_model.dart';
import 'package:seven_habit_rule/modules/shared/widgets/buttons.dart';
import 'package:seven_habit_rule/modules/shared/widgets/custom_textfield.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<TaskModel> tasks = [
    TaskModel(
      title: "Task 1",
      description:
          "Labore aliqua do ipsum labore commodo.Incididunt deserunt est excepteur laboris voluptate est labore excepteur.",
      status: false,
    ),
    TaskModel(
      title: "Task 2",
      status: true,
    ),
  ];

  addTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Add this line
      builder: (context) {
        return SingleChildScrollView(
          // Wrap the Column with SingleChildScrollView
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Adjust the padding to avoid hiding the bottom sheet
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  label: 'Title',
                  hintText: 'Enter the title of the task',
                ),
                const SizedBox(height: 20),
                GeneralButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(context);
                  },
                  title: 'Add Task',
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tasks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          actions: [
            IconButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                addTaskBottomSheet();
              },
              icon: Icon(Icons.add_rounded),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskTile(taskModel: tasks[index]);
            },
          ),
        ));
  }
}
