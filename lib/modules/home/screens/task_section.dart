import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seven_habit_rule/modules/home/widgets/task_tile.dart';
import 'package:seven_habit_rule/modules/shared/models/task_model.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';
import 'package:seven_habit_rule/modules/shared/widgets/transitions.dart';
import 'package:seven_habit_rule/modules/tasks/screens/task_details.dart';

class TaskSection extends StatefulWidget {
  const TaskSection({super.key});

  @override
  State<TaskSection> createState() => _TaskSectionState();
}

class _TaskSectionState extends State<TaskSection> {
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
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
                onPressed: () {
                  rightSlideTransition(context, const TaskDetails());
                },
                icon: Icon(Icons.add_rounded),
              ),
            ],
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('tasks')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<TaskModel> tasks = [];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data.docs.isEmpty) {
                return const SizedBox();
              }
              List data = snapshot.data.docs;
              tasks = data
                  .map(
                    (e) => TaskModel.fromJson({
                      "id": e.id,
                      ...e.data(),
                      "userId": uid,
                    }),
                  )
                  .toList();
              tasks.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));

              return SizedBox(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskTile(taskModel: tasks[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
