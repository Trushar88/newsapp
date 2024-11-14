import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/config/app_strings.dart';
import 'package:newsapp/base/base_controller.dart';
import 'package:newsapp/base/base_response.dart';
import 'package:newsapp/model/dio_exception.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:newsapp/routes/app_routes.dart';
import 'package:newsapp/ui/home/home_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends BaseController {
  HomeController get to => Get.find<HomeController>();
  final _screenName = "HomeController";

  List<NewsArticle> articles = [];
  int page = 1;
  bool isMoreData = true;
  String searchQuery = '';
  String selectedCategory = 'sport';
  List<String> categories = [];
  RxBool isListLoading = false.obs;

  TextEditingController cSearch = TextEditingController();

  final RefreshController refreshControllerStates = RefreshController(initialRefresh: false);

  @override
  void onInit() {
    fetchCategories();
    fetchNews(true);
    super.onInit();
  }

  fetchCategories() {
    categories = ['general', 'business', 'entertainment', 'health', 'science', 'sports', 'technology'];
    update();
  }

  loadMoreStates() async {
    if (isMoreData) {
      await fetchNews(
        false,
      );
      refreshControllerStates.loadComplete();
    } else {
      refreshControllerStates.loadNoData();
    }
  }

  searchByText() {
    try {
      selectedCategory = "";
      articles.clear();
      page = 1;
      refreshStates();
    } catch (err) {
      errorLog(_screenName, "searchByText", err.toString());
    }
  }

  searchByCategory(int index) {
    try {
      if (selectedCategory == categories[index]) {
        selectedCategory = "";
        fetchNews(true);
        update();
        return;
      }
      selectedCategory = categories[index];
      cSearch.clear();
      articles.clear();
      page = 1;
      update();
      refreshStates();
    } catch (err) {
      errorLog(_screenName, "searchByCategory", err.toString());
    }
  }

  refreshStates() async {
    try {
      await fetchNews(true);
      refreshControllerStates.refreshCompleted();
      refreshControllerStates.resetNoData();
    } catch (e) {
      refreshControllerStates.refreshFailed();
    }
  }

  moveToDetail(int index) {
    Get.toNamed(Routes.NEWSDETAIL, arguments: articles[index]);
  }

  Future<void> fetchNews(
    bool isInitCall,
  ) async {
    if (await checkNetwork(Get.context) == false) {
      return;
    } else {
      if (isInitCall) {
        articles.clear();
        showLoader(Get.context!);
      }
      isListLoading.value = true;

      try {
        BaseResponse? response = await HomeRepo().fetchNews(page, 20, cSearch.text, selectedCategory);
        if (response != null) {
          if (response.settings != null && response.settings!.statusCode == "ok") {
            isListLoading.value = false;
            if (isInitCall) {
              hideLoader(Get.context!);
            }
            if (isInitCall) {
              articles = response.data ?? [];
              update();
            } else {
              articles.addAll(response.data);
              update();
            }
            isMoreData = articles.length < response.settings!.count!;
            page++;
            update();
            if (isInitCall) {
              refreshControllerStates.refreshCompleted(); // Complete the refresh
            } else {
              refreshControllerStates.loadComplete(); // Complete the load more
            }
          } else {
            showSnackBar(Get.context!, message: response.settings!.message ?? APPSTRING.somethingwentwrong, type: 3);
          }
        } else {
          showSnackBar(Get.context!, message: APPSTRING.somethingwentwrong, type: 3);
        }
      } catch (e) {
        hideLoader(Get.context!);
        if (isInitCall) {
          refreshControllerStates.refreshFailed(); // Fail refresh
        } else {
          refreshControllerStates.loadFailed(); // Fail load more
        }

        if (e is DioExceptions) {
          showSnackBar(Get.context!, message: e.message, type: 3);
        }
      }
    }
  }
}
