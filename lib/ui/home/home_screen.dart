import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:newsapp/app/config/app_colors.dart';
import 'package:newsapp/app/config/app_strings.dart';
import 'package:newsapp/app/extensions/uicontext.dart';
import 'package:newsapp/base/base_body_widget.dart';

import 'package:newsapp/base/base_widget.dart';
import 'package:newsapp/common/custom_appbar.dart';
import 'package:newsapp/common/empty_widget.dart';
import 'package:newsapp/common/network_image.dart';
import 'package:newsapp/common/textfield_widget.dart';
import 'package:newsapp/routes/app_routes.dart';
import 'package:newsapp/ui/home/home_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:readmore/readmore.dart';

class HomeScreen extends BaseWidget {
  final _controller = HomeController().to; // Instance of Home _controller
  HomeScreen({Key? super.key, super.a, super.o}) : super(r: "HomeScreen");

  @override
  Widget build(BuildContext context) {
    return BaseBodyWidget(
      child: SafeArea(
          child: Scaffold(
              backgroundColor: APPCOLOR.GREYBG,
              appBar: MyAppBar(
                trailList: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(Routes.FAV);
                      },
                      child: Icon(
                        MdiIcons.heartOutline,
                        size: 28,
                      ),
                    ),
                  )
                ],
                title: APPSTRING.news,
              ),
              body: Padding(
                padding: context.bodyAllPadding.copyWith(top: 0),
                child: GetBuilder<HomeController>(
                    builder: (c) => Column(
                          children: [
                            AppTextFieldWidget(
                              controller: _controller.cSearch,
                              hintText: APPSTRING.searchHere,
                              isRoundedFiled: true,
                              onChanged: (c) {
                                _controller.searchByText();
                              },
                            ),
                            SizedBox(
                              height: 40,
                              child: Center(
                                child: ListView.builder(
                                  itemCount: _controller.categories.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: InkWell(
                                        onTap: () {
                                          _controller.searchByCategory(index);
                                        },
                                        child: Chip(
                                            side: const BorderSide(color: Colors.transparent),
                                            shadowColor: Colors.transparent,
                                            color: WidgetStatePropertyAll(_controller.categories[index] == _controller.selectedCategory ? APPCOLOR.PRIMARYCOLOR : Colors.white),
                                            label: Text(
                                              _controller.categories[index],
                                              style: context.customRegular(_controller.categories[index] == _controller.selectedCategory ? Colors.white : Colors.black, 14),
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: SmartRefresher(
                                controller: _controller.refreshControllerStates,
                                enablePullDown: true,
                                enablePullUp: true,
                                header: const WaterDropHeader(),
                                footer: CustomFooter(
                                  builder: (BuildContext context, LoadStatus? mode) {
                                    Widget body;
                                    if (mode == LoadStatus.loading) {
                                      body = Padding(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        child: Center(
                                            child: SizedBox(
                                                height: 25.0,
                                                width: 25.0,
                                                child: CircularProgressIndicator(
                                                  color: APPCOLOR.PRIMARYCOLOR,
                                                ))),
                                      );
                                    } else if (mode == LoadStatus.noMore) {
                                      body = Padding(
                                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                        child: Center(
                                            child: SizedBox(
                                                child: Text(
                                          "",
                                          style: context.customRegular(APPCOLOR.GREYCOLOR, 16),
                                        ))),
                                      );
                                    } else {
                                      body = Container();
                                    }
                                    return Center(child: body);
                                  },
                                ),
                                onLoading: _controller.loadMoreStates,
                                onRefresh: _controller.refreshStates,
                                child: _controller.articles.isEmpty
                                    ? Obx(() => _controller.isListLoading.value
                                        ? const SizedBox()
                                        : Column(
                                            children: [
                                              Expanded(
                                                  child: EmptyWidget(
                                                message: APPSTRING.noDataFound,
                                                subTitle: APPSTRING.newsNotAvailable,
                                                isImage: false,
                                              )),
                                            ],
                                          ))
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
                                                      AppNetworkImage(
                                                        height: 200,
                                                        width: Get.width,
                                                        boxFit: BoxFit.cover,
                                                        imageUrl: article.imageUrl,
                                                        backGroundColor: Colors.white,
                                                        radius: 15,
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
                                      ),
                              ),
                            ),
                          ],
                        )),
              ))),
    );
  }
}
