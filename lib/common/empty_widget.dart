// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:newsapp/app/config/app_assets.dart';
import 'package:newsapp/app/config/app_colors.dart';
import 'package:newsapp/app/extensions/uicontext.dart';

//Common Button Widget
class EmptyWidget extends StatelessWidget {
  final String message;
  final String? subTitle;
  bool isImage = false;
  final String? imagePath;

  EmptyWidget({super.key, required this.message, this.subTitle, this.isImage = false, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        isImage == true && imagePath != null
            ? SvgPicture.asset(
                imagePath ?? "",
                height: 150,
                width: Get.width,
              )
            : Lottie.asset(
                APPASSETS.noDataFound,
                height: 200,
                fit: BoxFit.contain,
                width: Get.width,
                animate: true,
                onLoaded: (composition) {},
              ),
        const SizedBox(
          height: 20,
        ),
        Text(message, style: context.customMedium(APPCOLOR.BlACKCOLOR, 18)),
        subTitle == null ? SizedBox() : Text(subTitle ?? "", textAlign: TextAlign.center, style: context.customRegular(APPCOLOR.BlACKCOLOR.withOpacity(0.5), 12))
      ],
    ));
  }
}
