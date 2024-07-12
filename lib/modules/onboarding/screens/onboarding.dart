import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seven_habit_rule/modules/shared/models/chat_model.dart';
import 'package:seven_habit_rule/modules/home/screens/home_screen.dart';
import 'package:seven_habit_rule/modules/shared/widgets/chat_tile.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';
import 'package:seven_habit_rule/modules/shared/widgets/snackbars.dart';

class UserOnboarding extends StatefulWidget {
  const UserOnboarding({super.key});

  @override
  State<UserOnboarding> createState() => _UserOnboardingState();
}

class _UserOnboardingState extends State<UserOnboarding> {
  String name = '';
  String goal = '';

  TextEditingController _controller = TextEditingController();

  List<ChatModel> initialChat = [
    ChatModel(
      message: 'Heyyy!',
      author: 'model',
    ),
    ChatModel(
      message:
          'Starting a business in your early 20s is not easy. You are brave enough to make that choice and I stand with you!',
      author: 'model',
    ),
    ChatModel(
      message:
          'Together we will go through the ups and downs of your journey and make sure you are on the right path.',
      author: 'model',
    ),
    ChatModel(
      message: 'Lets get started',
      author: 'user',
      chatType: 'SUGGESTION',
    ),
  ];

  List<ChatModel> askName = [
    ChatModel(
      message: 'Perfect! Lets get started',
      author: 'model',
    ),
    ChatModel(
      message: 'What is your first and last name?',
      author: 'model',
    ),
  ];
  List<ChatModel> askGoal = [
    ChatModel(
      message: 'Awesome! What is your business plan for the next 6 months?',
      author: 'model',
    ),
  ];
  List<ChatModel> chatList = [];

  Future<void> sendDataToFirebase() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uid).set({
      "name": name,
      "goal": goal,
      "created_at": DateTime.now().toIso8601String(),
    });
  }

  failedToUpload() {
    chatList.add(ChatModel(
      message: 'Retry',
      author: 'user',
      chatType: 'SUGGESTION',
    ));
    setState(() {});
  }

  void completeChat() {
    chatList.add(
      ChatModel(message: 'Creating a strategy...', author: 'model'),
    );

    sendDataToFirebase().then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      errorSnackBar(context, error.toString());
      failedToUpload();
    });
  }

  void initialMessage() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        chatList.add(initialChat[timer.tick - 1]);
      });
      if (timer.tick == initialChat.length) timer.cancel();
    });
  }

  void goalWave() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        chatList.add(askGoal[timer.tick - 1]);
      });
      if (timer.tick == askGoal.length) timer.cancel();
    });
  }

  void secondWave() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        chatList.add(askName[timer.tick - 1]);
      });
      if (timer.tick == askName.length) timer.cancel();
    });
  }

  @override
  void initState() {
    initialMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 2),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return ChatTile(
                      chat: chatList[index],
                      onTap: () {
                        HapticFeedback.vibrate();
                        if (chatList[index].chatType == 'SUGGESTION') {
                          if (chatList.last.message == 'Retry') {
                            ChatModel last = chatList[chatList.length - 1];
                            chatList.removeLast();
                            last = ChatModel(
                                chatType: '',
                                message: last.message,
                                author: 'user');
                            chatList.add(last);
                            completeChat();
                            setState(() {});
                          }
                          if (chatList.length == 4) {
                            ChatModel last = chatList[chatList.length - 1];
                            chatList.removeLast();
                            last = ChatModel(
                                chatType: '',
                                message: last.message,
                                author: 'user');
                            chatList.add(last);
                            setState(() {});

                            secondWave();
                          }
                        }
                      },
                    );
                  },
                ),
              ),
              if (chatList.length == 6 || chatList.length == 8)
                Container(
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: CustomColors.black10,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Message...',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: CustomColors.lightBlack,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_upward, color: Colors.white),
                          onPressed: () {
                            if (chatList.length == 6) {
                              if (_controller.text.isNotEmpty) {
                                name = _controller.text.trim();
                                setState(() {
                                  chatList.add(ChatModel(
                                    message: _controller.text.trim(),
                                    author: 'user',
                                  ));
                                });

                                _controller.clear();
                              }
                              goalWave();
                            }
                            if (chatList.length == 8) {
                              if (_controller.text.isNotEmpty) {
                                goal = _controller.text.trim();
                                setState(() {
                                  chatList.add(ChatModel(
                                    message: _controller.text.trim(),
                                    author: 'user',
                                  ));
                                });
                                _controller.clear();
                                completeChat();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
