// ignore_for_file: must_be_immutable, file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/config/app_assets.dart';
import 'package:newsapp/app/config/app_colors.dart';
import 'package:newsapp/app/config/app_strings.dart';
import 'package:newsapp/app/extensions/uicontext.dart';
import 'package:newsapp/base/base_widget.dart';
import 'package:newsapp/common/button_widget.dart';
import 'package:newsapp/routes/app_routes.dart';
import 'package:newsapp/ui/welcome/welcome_controller.dart';

class WelcomeScreen extends BaseWidget {
  final controller = WelcomeController().to; // Instance of login controller
  WelcomeScreen({Key? super.key, super.a, super.o}) : super(r: "WelcomeScreen");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: GetBuilder<WelcomeController>(builder: (c) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), image: const DecorationImage(image: AssetImage(APPASSETS.NEWIMAGE), fit: BoxFit.cover)),
              )),
              const SizedBox(
                height: 20,
              ),
              TweenAnimationBuilder(
                  tween: Tween<double>(begin: 1.0, end: c.scale), // Animate scale from 1.0 to _scale
                  duration: Duration(seconds: 1), // Duration of animation
                  curve: Curves.easeInOut, // Animation curve for smooth transition
                  builder: (context, scale, child) {
                    return Transform.scale(
                        scale: scale, // Apply the scale transformation
                        child: Text(
                          APPSTRING.newsForYou,
                          textAlign: TextAlign.center,
                          style: context.customSemiBold(APPCOLOR.BlACKCOLOR, 25),
                        ));
                  }),
              const SizedBox(
                height: 10,
              ),
              Text(
                APPSTRING.newsDesc,
                textAlign: TextAlign.center,
                style: context.customRegular(APPCOLOR.GREYCOLOR, 16),
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                width: c.isFullWidth ? MediaQuery.of(context).size.width : 150,
                height: 50,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(25)),
                alignment: Alignment.center,
                child: AppAuthCommonButtonWidget(
                  buttonName: APPSTRING.getStarted,
                  textColor: Colors.white,
                  onClick: () {
                    if (c.isFullWidth) {
                      Get.toNamed(Routes.HOME);
                    }
                  },
                  bgColor: APPCOLOR.PRIMARYCOLOR,
                  buttonWidth: Get.width,
                  imageIconPath: "",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      })),
    );
  }
}
