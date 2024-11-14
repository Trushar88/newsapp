// ignore_for_file: file_names

import 'dart:developer';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newsapp/app/service/network_service.dart';

class BaseController extends GetxController {
  final String _controllerName = "BaseController";
  NetworkController networkController = Get.find<NetworkController>();

  //Function errorLog print error log (only debug mode)
  errorLog(String screenName, String methodName, String err) => log("Exception - $methodName in $screenName :- $err ");

  //Funtion hideLoader remove loader from the context
  hideLoader(BuildContext context) {
    try {
      if (context.loaderOverlay.visible) {
        context.loaderOverlay.hide();
      }
    } catch (err) {
      errorLog(_controllerName, "hideLoader", err.toString());
    }
  }

  unFocusOverlay() => FocusManager.instance.primaryFocus?.unfocus();

  Future<bool> checkNetwork(context) async {
    await networkController.checkNetworkOnce();
    if (networkController.connectionStatus.value) {
      return true;
    } else {
      return false;
    }
  }

  showLoader(BuildContext context) => context.loaderOverlay.show();

  //Function showsnackbar use to show snackbar
  //type = 1 :- success
  //type = 2 :- warning
  //type = 3 :- error
  showSnackBar(
    BuildContext context, {
    String? title,
    required String message,
    int type = 1,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    try {
      IconData? icon;
      Color? color;

      //assign color and icon as per type
      switch (type) {
        case 1:
          icon = Icons.done_rounded;
          color = Colors.green;
          title = title ?? "Success";
          break;
        case 2:
          icon = Icons.warning;
          color = Colors.yellow;
          title = title ?? "Warning";
          break;
        case 3:
          icon = Icons.error;
          color = Colors.red;
          title = title ?? "Error";
          break;
      }

      Flushbar(
        title: title ?? "",
        message: message,
        icon: Icon(
          icon,
          size: 28.0,
          color: color,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        margin: const EdgeInsets.all(8),
        flushbarStyle: FlushbarStyle.FLOATING,
        duration: const Duration(seconds: 2),
        leftBarIndicatorColor: color,
      ).show(context);
    } catch (err) {
      errorLog(_controllerName, "showSnackBar", err.toString());
    }
  }
}
