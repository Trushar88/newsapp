import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newsapp/app/config/app_assets.dart';
import 'package:newsapp/app/config/app_colors.dart';
import 'package:newsapp/app/config/app_strings.dart';
import 'package:newsapp/app/extensions/uicontext.dart';
import 'package:newsapp/base/base_body_widget.dart';
import 'package:newsapp/base/base_widget.dart';
import 'package:newsapp/common/custom_appbar.dart';
import 'package:newsapp/common/empty_widget.dart';
import 'package:newsapp/common/network_image.dart';
import 'package:newsapp/ui/detail_page/news_detail_controller.dart';

class NewsDetailScreen extends BaseWidget {
  final _controller = NewsDetailController().to; // Instance of Home _controller
  NewsDetailScreen({Key? super.key, super.a, super.o}) : super(r: "NewsDetailScreen");

  @override
  Widget build(BuildContext context) {
    return BaseBodyWidget(
      child: SafeArea(
          child: Scaffold(
              backgroundColor: APPCOLOR.GREYBG,
              appBar: const MyAppBar(
                trailList: [],
                title: APPSTRING.newsDetail,
                leadingImage: APPASSETS.ARROW_LEFT,
              ),
              body: Padding(
                padding: context.bodyAllPadding.copyWith(top: 0),
                child: GetBuilder<NewsDetailController>(
                    builder: (c) => _controller.article != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  AppNetworkImage(
                                    height: 200,
                                    width: Get.width,
                                    boxFit: BoxFit.cover,
                                    imageUrl: _controller.article!.imageUrl,
                                    backGroundColor: Colors.white,
                                    radius: 15,
                                  ),
                                  Positioned(
                                      right: 10,
                                      top: 10,
                                      child: InkWell(
                                        onTap: () {
                                          _controller.clickLikeButton();
                                        },
                                        child: Icon(
                                          _controller.isFav ? MdiIcons.heart : MdiIcons.heartOutline,
                                          color: Colors.white,
                                        ),
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                _controller.article!.title,
                                style: context.customBold(Colors.black, 16),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                _controller.article!.description,
                                style: context.customRegular(Colors.grey, 14),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  _controller.clickWebLink(_controller.article!.url.toString());
                                },
                                child: Text(
                                  APPSTRING.clickSeeFullStory,
                                  style: context.customRegular(Colors.blue, 14).copyWith(
                                        decoration: TextDecoration.underline,
                                      ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          )
                        : EmptyWidget(
                            message: APPSTRING.noDataFound,
                            subTitle: APPSTRING.newsNotAvailable,
                            isImage: false,
                          )),
              ))),
    );
  }
}
