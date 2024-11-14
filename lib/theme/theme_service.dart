// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/service/local_storage.dart';

class ThemeService {
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }

  bool _loadThemeFromBox() => LocalStorageService().geThemeMode ?? false;

  _saveThemeToBox(bool isDarkMode) => LocalStorageService().setThemeMode(isDarkMode);
}
