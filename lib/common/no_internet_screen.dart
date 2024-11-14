import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/app/config/app_assets.dart';
import 'package:newsapp/app/config/app_colors.dart';
import 'package:newsapp/app/config/app_strings.dart';
import 'package:newsapp/app/extensions/uicontext.dart';
import 'package:newsapp/app/service/network_service.dart';

import 'button_widget.dart';

class NoInternetAlertScreen extends StatelessWidget {
  NoInternetAlertScreen({super.key});

  final _controller = NetworkController().to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              APPASSETS.noInternet,
              height: 300,
              fit: BoxFit.contain,
              width: Get.width,
              animate: true,
              onLoaded: (composition) {},
            ),
            Text(
              APPSTRING.oops,
              style: context.customSemiBold(APPCOLOR.GREYCOLOR, 30),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              APPSTRING.noInternetConnection,
              style: context.customRegular(APPCOLOR.BlACKCOLOR, 16),
            ),
            Text(
              APPSTRING.checkYourConnection,
              style: context.customRegular(APPCOLOR.BlACKCOLOR, 16),
            ),
            const SizedBox(
              height: 50,
            ),
            AppCommonButtonWidget(
              buttonName: APPSTRING.tryAgain,
              buttonWidth: 200,
              onClick: () {
                _controller.checkNetworkOnce();
              },
              bgColor: APPCOLOR.BlACKCOLOR,
            )
          ],
        ),
      ),
    );
  }
}
