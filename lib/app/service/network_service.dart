// ignore_for_file: file_names, unused_field, missing_return, body_might_complete_normally_nullable

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  RxBool connectionStatus = false.obs;
  NetworkController get to => Get.find<NetworkController>();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;

  Future<bool> checkNetworkOnce() async {
    dynamic result = await _connectivity.checkConnectivity();
    dynamic checkInitResult = updateConnectivity(result);
    try {
      if (checkInitResult == 0) {
        connectionStatus.value = false;
        update(); // if connected with wifi status set 1
        return false;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          connectionStatus.value = true;
          update(); // if connected with wifi status set 1
          return true;
        } else {
          connectionStatus.value = false;
          update(); // if connected with wifi status set 1
          return false;
        }
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  List<ConnectivityResult> resultData = [];

  Future<void> initConnectivity() async {
    try {
      resultData = await _connectivity.checkConnectivity();
    } catch (e) {
      log(e.toString());
    }
    return updateConnectivity(resultData);
  }

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    connectivitySubscription = _connectivity.onConnectivityChanged.listen(updateConnectivity); // network check listener
  }

  updateConnectivity(List<ConnectivityResult> result) async {
    switch (result.first) {
      case ConnectivityResult.mobile:
        connectionStatus.value = true; // if connected with wifi status set 1
        break;
      case ConnectivityResult.wifi:
        connectionStatus.value = true; // if connected with wifi status set 2
        break;
      case ConnectivityResult.none:
        connectionStatus.value = false;
        break;
      default:
    }
  }

  @override
  void onClose() {
    connectivitySubscription.cancel();
  }
}
