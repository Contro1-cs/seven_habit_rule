import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        padding: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: taskModel.status
              ? CustomColors.darkBlue.withOpacity(0.7)
              : CustomColors.darkBlue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              taskModel.title,
              style: TextStyle(
                decoration:
                    taskModel.status ? TextDecoration.lineThrough : null,
                decorationThickness: 1.5,
                decorationColor: CustomColors.white,
                color: taskModel.status
                    ? CustomColors.white.withOpacity(0.5)
                    : CustomColors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            CustomCheckbox(
              value: taskModel.status,
              onTap: () {
                String uid = FirebaseAuth.instance.currentUser!.uid;
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(uid)
                    .collection('tasks')
                    .doc(taskModel.id)
                    .update({
                  'status': !taskModel.status,
                  'updatedAt': DateTime.now().toIso8601String(),
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
