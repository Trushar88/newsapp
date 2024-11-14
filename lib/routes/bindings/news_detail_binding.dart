import 'package:get/get.dart';
import 'package:newsapp/ui/detail_page/news_detail_controller.dart';

class NewsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailController>(() => NewsDetailController());
  }
}
