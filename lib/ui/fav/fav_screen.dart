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
import 'package:newsapp/ui/fav/fav_controller.dart';
import 'package:readmore/readmore.dart';

class FavScreen extends BaseWidget {
  final _controller = FavController().to; // Instance of Home _controller
  FavScreen({Key? super.key, super.a, super.o}) : super(r: "FavScreen");

  @override
  Widget build(BuildContext context) {
    return BaseBodyWidget(
      child: SafeArea(
          child: Scaffold(
              backgroundColor: APPCOLOR.GREYBG,
              appBar: const MyAppBar(
                trailList: [],
                title: APPSTRING.favorite,
                leadingImage: APPASSETS.ARROW_LEFT,
              ),
              body: Padding(
                padding: context.bodyAllPadding.copyWith(top: 0),
                child: GetBuilder<FavController>(
                    builder: (c) => _controller.articles.isEmpty
                        ? Column(
                            children: [
                              Expanded(
                                  child: EmptyWidget(
                                message: APPSTRING.noFavDataFound,
                                subTitle: APPSTRING.newsNotAvailableInFav,
                                isImage: false,
                              )),
                            ],
                          )
                        : ListView.builder(
                            itemCount: _controller.articles.length, // Add one more item for the loading spinner
                            itemBuilder: (context, index) {
                              if (index == _controller.articles.length) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              final article = _controller.articles[index];
                              return InkWell(
                                onTap: () {
                                  _controller.moveToDetail(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey.withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              AppNetworkImage(
                                                height: 200,
                                                width: Get.width,
                                                boxFit: BoxFit.cover,
                                                imageUrl: article.imageUrl,
                                                backGroundColor: Colors.white,
                                                radius: 15,
                                              ),
                                              Positioned(
                                                  right: 10,
                                                  top: 10,
                                                  child: InkWell(
                                                    onTap: () {
                                                      _controller.clickRemoveFav(index);
                                                    },
                                                    child: Icon(
                                                      MdiIcons.heart,
                                                      color: Colors.white,
                                                    ),
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            article.title,
                                            style: context.customBold(Colors.black, 16),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: ReadMoreText(
                                              article.description,
                                              trimLines: 3,
                                              trimMode: TrimMode.Line,
                                              colorClickableText: APPCOLOR.PRIMARYCOLOR,
                                              style: context.customRegular(Colors.grey, 14),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
              ))),
    );
  }
}
