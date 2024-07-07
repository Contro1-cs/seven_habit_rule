import 'package:flutter/material.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';

class GeneralButton extends StatelessWidget {
  final String? title;
  final Widget? icon;
  final Function()? onPressed;
  const GeneralButton({
    super.key,
    this.title,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomColors.darkBlue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null) const SizedBox(width: 10),
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  color: CustomColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
