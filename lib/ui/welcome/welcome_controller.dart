import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/base/base_controller.dart';

class WelcomeController extends BaseController {
  WelcomeController get to => Get.find<WelcomeController>();
  TextEditingController mobileController = TextEditingController();
  double scale = 0.5;

  bool isFullWidth = false; // Track the width state

  void changeSizeValue() {
    Future.delayed(Duration(seconds: 1)).then((c) {
      isFullWidth = true;
      scale = 1.0;
      update();
    });
  }

  @override
  void onInit() {
    changeSizeValue();
    super.onInit();
  }
}
