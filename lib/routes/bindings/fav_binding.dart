import 'package:get/get.dart';
import 'package:newsapp/ui/fav/fav_controller.dart';

class FavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavController>(() => FavController());
  }
}
