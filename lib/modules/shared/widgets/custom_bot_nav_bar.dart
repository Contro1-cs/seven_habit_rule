import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seven_habit_rule/modules/riverpod/bottom_nav_bar_counter.dart';

class CustomBotNavBar extends ConsumerStatefulWidget {
  const CustomBotNavBar({super.key});

  @override
  ConsumerState<CustomBotNavBar> createState() => _CustomBotNavBarState();
}

class _CustomBotNavBarState extends ConsumerState<CustomBotNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(navbarProvider.notifier).changePage(0);
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      ref.watch(navbarProvider).page == 0
                          ? "assets/icons/home_selected.svg"
                          : "assets/icons/home.svg",
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Home",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(navbarProvider.notifier).changePage(1);
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      ref.watch(navbarProvider).page == 1
                          ? "assets/icons/task_selected.svg"
                          : "assets/icons/task.svg",
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tasks",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(navbarProvider.notifier).changePage(2);
              },
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      ref.watch(navbarProvider).page == 2
                          ? "assets/icons/profile_selected.svg"
                          : "assets/icons/profile.svg",
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Profile",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
