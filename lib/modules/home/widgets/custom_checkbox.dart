import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final Function(bool) onChanged;
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: widget.value ? CustomColors.white : CustomColors.darkBlue,
        border: Border.all(
          color: CustomColors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: widget.value ? SvgPicture.asset("assets/icons/check.svg") : null,
    );
  }
}
