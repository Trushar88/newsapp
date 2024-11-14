import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

//Custom AppBar widget
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> trailList;
  final String? leadingImage;
  const MyAppBar({super.key, required this.title, required this.trailList, this.leadingImage});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: preferredSize,
        child: AppBar(
          leading: leadingImage != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset(
                        leadingImage!,
                        height: 20,
                        width: 20,
                        color: Colors.black,
                      )),
                )
              : const SizedBox(),
          leadingWidth: 45,
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          centerTitle: true,
          bottomOpacity: 0,
          forceMaterialTransparency: true,
          automaticallyImplyLeading: false,
          actions: trailList,
          title: Text(title),
        ));
  }
}
