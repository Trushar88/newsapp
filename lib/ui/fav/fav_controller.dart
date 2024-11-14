import 'package:get/get.dart';
import 'package:newsapp/app/service/local_storage.dart';
import 'package:newsapp/base/base_controller.dart';

import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/routes/app_routes.dart';

class FavController extends BaseController {
  FavController get to => Get.find<FavController>();
  final _screenName = "FavController";

  List<NewsArticle> articles = [];

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  moveToDetail(int index) {
    Get.toNamed(Routes.NEWSDETAIL, arguments: articles[index]);
  }

  fetchNews() {
    try {
      articles = LocalStorageService().articles ?? [];
      update();
    } catch (err) {
      errorLog(_screenName, "fetchNews", err.toString());
    }
  }

  void clickRemoveFav(int index) async {
    try {
      articles.removeWhere((e) => e.author == articles[index].author);
      bool isAdded = await LocalStorageService().setArticles(articles);
      if (isAdded) {
        update();
      }
      update();
    } catch (err) {
      errorLog(_screenName, "clickLikeButton", err.toString());
    }
  }
}
