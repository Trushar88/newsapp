// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:newsapp/app/config/app_colors.dart';

class Themes {
  //light theme
  static final light = ThemeData.light().copyWith(
    primaryColor: APPCOLOR.PRIMARYCOLOR,
    scaffoldBackgroundColor: APPCOLOR.GREYBG,
  );
  //light theme
  static final dark = ThemeData.dark().copyWith(
    primaryColor: APPCOLOR.DARKPRIMARYCOLOR,
  );
}
