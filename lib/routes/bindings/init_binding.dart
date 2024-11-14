import 'package:get/get.dart';
import 'package:newsapp/ui/welcome/welcome_controller.dart';
import 'package:newsapp/app/service/network_service.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController());
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }
}
