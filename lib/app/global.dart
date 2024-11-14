import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String appName = "newsapp"; //AppName
const String appVerison = "0.0.1"; // AppVersion

String? currentLang; //Current Active Language

String newsAPIKey = "4d61ec2cf2af4291a87413da3ef66bf1";

SharedPreferences? sharedPreferences;
final GlobalKey<ScaffoldMessengerState> snackbarKey = GlobalKey<ScaffoldMessengerState>();
