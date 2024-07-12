import 'package:flutter/material.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';

class BigIconTile extends StatelessWidget {
  final String title;
  final Widget icon;
  final Function()? onTap;
  const BigIconTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: BoxDecoration(
            color: CustomColors.darkBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: CustomColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
