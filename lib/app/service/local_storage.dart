import 'dart:developer';
import 'package:get/get.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:newsapp/app/global.dart' as global;

enum _Key {
  thememode,
  currentLang,
  articles,
}

class LocalStorageService extends GetxService {
  Future<LocalStorageService> init() async {
    global.sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  setThemeMode(bool data) {
    try {
      global.sharedPreferences?.setBool(_Key.thememode.toString(), data);
    } catch (err) {
      errorLog("setThemeMode", err.toString());
    }
  }

  setCurrentLanguage(String data) {
    try {
      global.sharedPreferences?.setString(_Key.currentLang.toString(), data);
    } catch (err) {
      errorLog("setCurrentLanguage", err.toString());
    }
  }

  String? get getCurrentLanguage {
    try {
      String? currentLang = global.sharedPreferences?.getString(_Key.thememode.toString());
      if (currentLang == null) {
        return null;
      }

      return currentLang;
    } catch (err) {
      errorLog("getThemeMode", err.toString());
    }
    return null;
  }

  bool? get geThemeMode {
    try {
      bool? currentTheme = global.sharedPreferences?.getBool(_Key.thememode.toString());
      if (currentTheme == null) {
        return null;
      }

      return currentTheme;
    } catch (err) {
      errorLog("getThemeMode", err.toString());
    }
    return null;
  }

  List<NewsArticle>? get articles {
    try {
      List<String>? rawJson = global.sharedPreferences?.getStringList(_Key.articles.toString());
      if (rawJson == null) {
        return null;
      }
      return rawJson.map((jsonString) => NewsArticle.fromMapLocal(jsonString)).toList();
    } catch (err) {
      return [];
    }
  }

  Future<bool> setArticles(List<NewsArticle> articles) async {
    try {
      if (articles.isNotEmpty) {
        List<String> jsonUserList = articles.map((user) => user.toJsonString()).toList();
        return await global.sharedPreferences?.setStringList(_Key.articles.toString(), jsonUserList) ?? false;
      } else {
        return await global.sharedPreferences?.remove(_Key.articles.toString()) ?? false;
      }
    } catch (err) {
      errorLog("setArticles", err.toString());
      return false;
    }
  }

  errorLog(String fun, String err) {
    log("Local Storage $fun  error :- $err");
  }
}
