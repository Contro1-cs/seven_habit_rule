import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seven_habit_rule/modules/home/widgets/task_tile.dart';
import 'package:seven_habit_rule/modules/riverpod/bottom_nav_bar_counter.dart';
import 'package:seven_habit_rule/modules/shared/models/task_model.dart';
import 'package:seven_habit_rule/modules/shared/widgets/transitions.dart';
import 'package:seven_habit_rule/modules/tasks/screens/task_details.dart';

class TaskScreen extends ConsumerStatefulWidget {
  const TaskScreen({super.key});

  @override
  ConsumerState<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends ConsumerState<TaskScreen> {
  TextEditingController titleController = TextEditingController();
  List<TaskModel> tasks = [];

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        ref.watch(navbarProvider.notifier).changePage(0);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tasks',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          actions: [
            IconButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                rightSlideTransition(context, const TaskDetails());
              },
              icon: Icon(Icons.add_rounded),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .collection('tasks')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data.docs.isEmpty) {
                return const Center(
                  child: Text('No tasks added yet'),
                );
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
              tasks.sort((b, a) => a.createdAt.compareTo(b.createdAt));

              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return TaskTile(taskModel: tasks[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
