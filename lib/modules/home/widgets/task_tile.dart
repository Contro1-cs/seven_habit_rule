import 'package:flutter/material.dart';
import 'package:seven_habit_rule/modules/home/widgets/custom_checkbox.dart';
import 'package:seven_habit_rule/modules/shared/models/task_model.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';
import 'package:seven_habit_rule/modules/shared/widgets/transitions.dart';
import 'package:seven_habit_rule/modules/tasks/screens/task_details.dart';

class TaskTile extends StatelessWidget {
  final TaskModel taskModel;
  const TaskTile({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        rightSlideTransition(
          context,
          TaskDetails(taskModel: taskModel),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.fromLTRB(16, 4, 6, 4),
        decoration: BoxDecoration(
          color: CustomColors.darkBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              taskModel.title,
              style: const TextStyle(
                color: CustomColors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            CustomCheckbox(
              value: taskModel.status,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
