import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/app/config/app_colors.dart';
import 'package:newsapp/app/extensions/decoration_ex.dart';
import 'package:newsapp/app/extensions/uicontext.dart';

class AppTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon; //if you don't want to set icon the pass null
  final Widget? suffixIcon; //if you don't want to set icon the pass null
  final bool? isReadOnly;
  final bool? isObscure;
  final bool? isCurruncy;
  final String? lable;
  final int? length;
  final Color? lableTextColor;
  final VoidCallback? suffixIconTouch;
  final double? hintSize;
  final VoidCallback? onTapFiled;
  final bool isRoundedFiled;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final Function? onValidate;
  final Function? onChanged;
  final TextInputAction? textInputAction;
  final TextInputType? keyBoardType;
  final Color? hintColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;

  const AppTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.isReadOnly,
    this.prefixIcon,
    this.suffixIcon,
    this.lable,
    this.isObscure,
    this.isCurruncy,
    this.suffixIconTouch,
    this.onTapFiled,
    this.length,
    this.lableTextColor,
    this.onEditingComplete,
    this.focusNode,
    this.isRoundedFiled = false,
    this.onValidate,
    this.onChanged,
    this.hintSize,
    this.hintColor,
    this.textInputAction,
    this.inputFormatters,
    this.textCapitalization,
    this.keyBoardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: isReadOnly ?? false,
        obscureText: isObscure ?? false,
        controller: controller,
        onTap: onTapFiled,
        maxLength: length,
        keyboardType: keyBoardType, //TextInputType.number
        focusNode: focusNode,
        //cursorErrorColor: APPCOLOR.PRIMARYCOLOR,
        validator: (value) => onValidate?.call(value),
        onChanged: (value) => onChanged?.call(value),
        onEditingComplete: onEditingComplete,
        inputFormatters: inputFormatters ?? [],
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        enableSuggestions: true,
        cursorColor: APPCOLOR.BlACKCOLOR,
        style: context.customRegular(APPCOLOR.BlACKCOLOR, 16),
        decoration: isRoundedFiled
            ? const InputDecoration().customRoundedTextFieldDecoration(hintText, prefixIcon, suffixIcon, context.customRegular(hintColor ?? APPCOLOR.GREYCOLOR, 16))
            : const InputDecoration().customTextFieldDecoration(hintText, prefixIcon, suffixIcon, context.customRegular(hintColor ?? APPCOLOR.GREYCOLOR, hintSize ?? 16)));
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
