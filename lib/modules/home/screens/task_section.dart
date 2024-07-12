import 'package:flutter/material.dart';
import 'package:seven_habit_rule/modules/home/widgets/task_tile.dart';
import 'package:seven_habit_rule/modules/shared/models/task_model.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';

class TaskSection extends StatefulWidget {
  const TaskSection({super.key});

  @override
  State<TaskSection> createState() => _TaskSectionState();
}

class _TaskSectionState extends State<TaskSection> {
  @override
  Widget build(BuildContext context) {
    List<TaskModel> tasks = [
      // TaskModel(
      //   title: "Task 1",
      //   description: "Description 1",
      //   status: false,
      // ),
      // TaskModel(
      //   title: "Task 2",
      //   description: "Description 2",
      //   status: true,
      // ),
    ];
    return Container(
      padding: const EdgeInsets.only(top: 10),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tasks",
                style: const TextStyle(
                  color: CustomColors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_rounded),
              ),
            ],
          ),
          if (tasks.isNotEmpty)
            ListView.builder(
              shrinkWrap: true,
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(taskModel: tasks[index]);
              },
            ),
        ],
      ),
    );
  }
}
