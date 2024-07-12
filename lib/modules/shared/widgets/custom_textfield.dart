import 'package:flutter/material.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final int? maxLines;
  final String? hintText;
  final String? errorText;
  final TextInputType? textInputType;
  final bool obscureText;
  final TextStyle? textStyle;
  const CustomTextField({
    super.key,
    this.label,
    this.controller,
    this.maxLines,
    this.hintText,
    this.errorText,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.textStyle = const TextStyle(
      color: CustomColors.lightBlack,
      fontSize: 18,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                label!,
                style: const TextStyle(
                  color: CustomColors.lightBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: textInputType,
            maxLines: maxLines ?? 1,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.3),
                fontSize: 14,
              ),
              errorText: errorText,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: CustomColors.red),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: CustomColors.black10,
            ),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
