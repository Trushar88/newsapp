import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/service/local_storage.dart';
import 'package:newsapp/base/base_controller.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/ui/webview_page/web_view_screen.dart';

class NewsDetailController extends BaseController {
  NewsDetailController get to => Get.find<NewsDetailController>();
  final _screenName = "NewsDetailController";

  NewsArticle? article = Get.arguments;
  List<NewsArticle> localArticle = [];
  bool isFav = false;

  void clickLikeButton() async {
    try {
      if (isFav) {
        localArticle.removeWhere((e) => e.author == article!.author);
        bool isAdded = await LocalStorageService().setArticles(localArticle);
        if (isAdded) {
          isFav = false;
          update();
        }
      } else {
        localArticle.add(article!);
        bool isAdded = await LocalStorageService().setArticles(localArticle);
        if (isAdded) {
          isFav = true;
          update();
        }
      }
    } catch (err) {
      errorLog(_screenName, "clickLikeButton", err.toString());
    }
  }

  @override
  void onInit() {
    getArticles();
    super.onInit();
  }

  getArticles() {
    localArticle = LocalStorageService().articles ?? [];
    if (localArticle.isNotEmpty) {
      if (localArticle.where((e) => e.author == article!.author).isNotEmpty) {
        isFav = true;
        update();
      }
    }
  }

  void clickWebLink(String link) {
    Navigator.of(Get.context!).push(MaterialPageRoute(
      builder: (context) {
        return WebViewScreen(url: link);
      },
    ));
  }
}
