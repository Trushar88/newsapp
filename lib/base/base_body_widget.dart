// ignore_for_file: prefer_const_constructors_in_immutables, file_names, must_be_immutable
import 'package:newsapp/common/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/service/network_service.dart';

class BaseBodyWidget extends StatelessWidget {
  final Widget child;
  final bool isSafeArea;

  BaseBodyWidget({super.key, required this.child, this.isSafeArea = true});

  @override
  Widget build(BuildContext context) {
    return isSafeArea
        ? SafeArea(
            bottom: false,
            top: false,
            child: GetBuilder<NetworkController>(builder: (c) {
              return Obx(() => c.connectionStatus.value ? child : NoInternetAlertScreen());
            }),
          )
        : GetBuilder<NetworkController>(builder: (c) {
            return Obx(() => c.connectionStatus.value ? child : NoInternetAlertScreen());
          });
  }
}
