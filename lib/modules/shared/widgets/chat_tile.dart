import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:seven_habit_rule/modules/shared/models/chat_model.dart';
import 'package:seven_habit_rule/modules/shared/widgets/colors.dart';

class ChatTile extends StatelessWidget {
  final ChatModel chat;
  final Function()? onTap;
  const ChatTile({
    super.key,
    this.onTap,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    bool isModel = chat.author == 'model';
    return Align(
      alignment: isModel ? Alignment.topLeft : Alignment.topRight,
      child: chat.chatType == "SUGGESTION"
          ? GestureDetector(
              onTap: onTap,
              child: DottedBorder(
                strokeCap: StrokeCap.square,
                color: CustomColors.darkBlue,
                strokeWidth: 1.5,
                borderType: BorderType.RRect,
                dashPattern: [10],
                radius: Radius.circular(12),
                padding: EdgeInsets.all(6),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        chat.message,
                        style: TextStyle(
                          fontSize: 18,
                          color: CustomColors.darkBlue,
                        ),
                      ),
                    )),
              ),
            )
          : Wrap(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 10,
                    left: isModel ? 0 : 50,
                    right: isModel ? 50 : 0,
                  ),
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: isModel
                        ? CustomColors.darkBlue
                        : chat.chatType == 'SUGGESTION'
                            ? CustomColors.white
                            : CustomColors.blue,
                    border: chat.chatType == 'SUGGESTION'
                        ? Border.all(color: CustomColors.lightBlue)
                        : null,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(isModel ? 0 : 20),
                      bottomRight: Radius.circular(isModel ? 20 : 0),
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                    ),
                  ),
                  child: isModel
                      ? AnimatedTextKit(
                          totalRepeatCount: 1,
                          animatedTexts: [
                            TyperAnimatedText(
                              chat.message,
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: CustomColors.white,
                              ),
                              speed: const Duration(
                                milliseconds: 20,
                              ),
                            )
                          ],
                        )
                      : Text(
                          chat.message,
                          style: TextStyle(
                            fontSize: 18,
                            color: CustomColors.white,
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}
