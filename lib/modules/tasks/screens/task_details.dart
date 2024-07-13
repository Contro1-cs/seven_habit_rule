import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:seven_habit_rule/modules/shared/models/task_model.dart';
import 'package:seven_habit_rule/modules/shared/widgets/buttons.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';
import 'package:seven_habit_rule/modules/shared/widgets/custom_textfield.dart';
import 'package:seven_habit_rule/modules/shared/widgets/transitions.dart';

class TaskDetails extends StatefulWidget {
  final TaskModel? taskModel;
  const TaskDetails({
    super.key,
    this.taskModel,
  });

  @override
  State<TaskDetails> createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  List<XFile> _images = [];
  bool error = false;
  bool status = false;

  createNewTask() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .add({
      'title': _titleController.text.trim(),
      'status': false,
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    }).then((value) {
      _titleController.clear();
      Navigator.pop(context);
    });
  }

  updateTask() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .doc(widget.taskModel!.id)
        .update({
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  pickImage() {
    ImagePicker().pickMultiImage().then((image) {
      if (image.isNotEmpty) {
        setState(() {
          _images.addAll(image);
        });
      }
    });
  }

  @override
  void initState() {
    if (widget.taskModel != null) {
      _titleController.text = widget.taskModel!.title;
      _descriptionController.text = widget.taskModel!.description;
      status = widget.taskModel!.status;
    }
    super.initState();
  }

  @override
  void dispose() {
    updateTask();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: _titleController,
                    autofocus: widget.taskModel == null,
                    hintText: 'Enter the title',
                    errorText: error && _titleController.text.trim().isEmpty
                        ? 'Title cannot be empty'
                        : null,
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: _descriptionController,
                          maxLines: null,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write the description...'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Attach Photo",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 80,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _images.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                upSlideTransition(
                                                  context,
                                                  PhotoView(
                                                    imageProvider: FileImage(
                                                      File(_images[index].path),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                margin: const EdgeInsets.only(
                                                  right: 10,
                                                  top: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: FileImage(
                                                      File(_images[index].path),
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _images.removeAt(index);
                                                  });
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                    color: CustomColors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: CustomColors.white,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        pickImage();
                                      },
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.add_rounded,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox(height: 50)),
                  if (status && widget.taskModel != null)
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(
                            color: CustomColors.darkBlue,
                          ),
                          backgroundColor: CustomColors.white,
                        ),
                        onPressed: () {
                          String uid = FirebaseAuth.instance.currentUser!.uid;
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .collection('tasks')
                              .doc(widget.taskModel!.id)
                              .update({
                            'status': !widget.taskModel!.status,
                            'updatedAt': DateTime.now().toIso8601String(),
                          }).then((value) {
                            setState(() {
                              status = false;
                            });
                          });
                        },
                        child: Text(
                          'Mark as incomplete',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (!status && widget.taskModel != null)
                    GeneralButton(
                      title: 'Mark as complete',
                      color: CustomColors.green,
                      onPressed: () {
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .collection('tasks')
                            .doc(widget.taskModel!.id)
                            .update({
                          'status': !widget.taskModel!.status,
                          'updatedAt': DateTime.now().toIso8601String(),
                        }).then((value) {
                          setState(() {
                            status = true;
                          });
                        });
                      },
                    ),
                  if (widget.taskModel == null)
                    GeneralButton(
                      title: 'Create Task',
                      onPressed: () {
                        if (_titleController.text.trim().isEmpty) {
                          setState(() {
                            error = true;
                          });
                        } else {
                          createNewTask();
                        }
                      },
                    ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
