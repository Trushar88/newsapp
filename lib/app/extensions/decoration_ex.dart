import 'package:flutter/material.dart';
import 'package:newsapp/app/config/app_colors.dart';

extension CommonInputDecoration on InputDecoration {
  InputDecoration customTextFieldDecoration(String hint, Widget? prefix, Widget? suffix, TextStyle hintStyle) {
    var returnResult = InputDecoration(
      hintText: hint,
      labelText: hint,
      alignLabelWithHint: false,
      suffixIcon: suffix,
      suffixIconConstraints: const BoxConstraints(minWidth: 25, maxWidth: 25, maxHeight: 25, minHeight: 25),
      contentPadding: const EdgeInsets.only(top: 5, right: 5, bottom: 5, left: 0),
      prefix: prefix,
      constraints: const BoxConstraints(maxHeight: 60, minHeight: 60),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: hintStyle,
      hintStyle: hintStyle,
      isCollapsed: true,
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: APPCOLOR.LIGHTGREY,
        ),
      ),
      counterText: "",
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: APPCOLOR.LIGHTGREY,
        ),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: APPCOLOR.LIGHTGREY,
        ),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: APPCOLOR.LIGHTGREY,
        ),
      ),
    );
    return returnResult;
  }

  InputDecoration customRoundedTextFieldDecoration(String hint, Widget? prefix, Widget? suffix, TextStyle hintStyle) {
    var returnResult = InputDecoration(
      hintText: hint,
      labelText: hint,
      alignLabelWithHint: false,
      suffixIcon: suffix,
      suffixIconConstraints: const BoxConstraints(minWidth: 25, maxWidth: 25, maxHeight: 25, minHeight: 25),
      contentPadding: const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
      prefix: prefix,
      constraints: const BoxConstraints(maxHeight: 60, minHeight: 60),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: hintStyle,
      hintStyle: hintStyle,
      fillColor: Colors.white,
      isCollapsed: true,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide(
            //color: APPCOLOR.PRIMARYCOLOR,
            ),
      ),
      counterText: "",
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide(
            // color: APPCOLOR.PRIMARYCOLOR,
            ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: const BorderSide(
            //  color: Colors.red,
            ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide(
            //  / color: APPCOLOR.PRIMARYCOLOR,
            ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(60),
        borderSide: BorderSide(
            // color: APPCOLOR.PRIMARYCOLOR,
            ),
      ),
    );
    return returnResult;
  }
}
