import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seven_habit_rule/modules/home/screens/home_screen.dart';
import 'package:seven_habit_rule/modules/profile/screens/profile_screen.dart';
import 'package:seven_habit_rule/modules/riverpod/bottom_nav_bar_counter.dart';
import 'package:seven_habit_rule/modules/shared/widgets/custom_bot_nav_bar.dart';
import 'package:seven_habit_rule/modules/tasks/screens/task_screen.dart';

class BotNavBar extends ConsumerStatefulWidget {
  const BotNavBar({super.key});

  @override
  ConsumerState<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends ConsumerState<BotNavBar> {
  List<Widget> screens = [
    const HomeScreen(),
    const TaskScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[ref.watch(navbarProvider).page],
      bottomNavigationBar: CustomBotNavBar(),
    );
  }
}
