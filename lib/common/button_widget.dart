// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:flutter/material.dart';
import 'package:newsapp/app/config/app_colors.dart';
import 'package:newsapp/app/extensions/uicontext.dart';

//Common Button Widget
class AppCommonButtonWidget extends StatelessWidget {
  final String buttonName;
  final double buttonWidth;
  final VoidCallback onClick;
  final Color? buttonTextColor;
  final Color? bgColor;
  final bool isDisabled; // Add the isDisabled property

  AppCommonButtonWidget({
    super.key,
    required this.buttonName,
    required this.buttonWidth,
    required this.onClick,
    this.buttonTextColor,
    this.bgColor,
    this.isDisabled = false,
  });
  DateTime? loginClickTime;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
        ),
        height: 50,
        width: buttonWidth,
        child: FilledButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(isDisabled ? APPCOLOR.GREYCOLOR : (bgColor ?? APPCOLOR.PRIMARYCOLOR)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)))),
          onPressed: isDisabled
              ? null
              : () {
                  if (isRedundentClick(DateTime.now())) {
                    return;
                  }
                  onClick();
                },
          child: Text(
            buttonName,
            style: context.customSemiBold(buttonTextColor ?? Colors.white, 16),
          ),
        ),
      ),
    );
  }

  bool isRedundentClick(DateTime currentTime) {
    try {
      if (loginClickTime == null) {
        loginClickTime = currentTime;
        return false;
      }
      if (currentTime.difference(loginClickTime!).inSeconds < 2) {
        return true;
      }
      loginClickTime = currentTime;
      return false;
    } catch (err) {
      return false;
    }
  }
}

class AppAuthCommonButtonWidget extends StatelessWidget {
  final String buttonName;
  final double buttonWidth;
  final VoidCallback onClick;
  final Color? bgColor;
  final String? imageIconPath;
  final Color? textColor;

  AppAuthCommonButtonWidget({super.key, required this.buttonName, required this.buttonWidth, required this.onClick, this.bgColor, required this.imageIconPath, this.textColor});
  DateTime? loginClickTime;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
        ),
        height: 50,
        width: buttonWidth,
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(bgColor ?? Colors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60), side: BorderSide(color: APPCOLOR.GREYCOLOR)),
            ),
          ),
          onPressed: () {
            if (isRedundentClick(DateTime.now())) {
              return;
            }
            onClick();
          },
          child: Text(
            buttonName,
            style: context.customMedium(textColor ?? APPCOLOR.BlACKCOLOR, 14),
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  bool isRedundentClick(DateTime currentTime) {
    try {
      if (loginClickTime == null) {
        loginClickTime = currentTime;
        return false;
      }
      if (currentTime.difference(loginClickTime!).inSeconds < 2) {
        return true;
      }
      loginClickTime = currentTime;
      return false;
    } catch (err) {
      return false;
    }
  }
}
