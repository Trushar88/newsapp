import 'package:get/get.dart';
import 'package:newsapp/routes/bindings/fav_binding.dart';
import 'package:newsapp/routes/bindings/init_binding.dart';
import 'package:newsapp/routes/bindings/home_binding.dart';
import 'package:newsapp/routes/app_routes.dart';
import 'package:newsapp/routes/bindings/news_detail_binding.dart';
import 'package:newsapp/ui/detail_page/news_detail_screen.dart';
import 'package:newsapp/ui/fav/fav_screen.dart';
import 'package:newsapp/ui/home/home_screen.dart';
import 'package:newsapp/ui/welcome/welcome_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => WelcomeScreen(), binding: InitBinding()),
    GetPage(name: Routes.HOME, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: Routes.NEWSDETAIL, page: () => NewsDetailScreen(), binding: NewsDetailBinding()),
    GetPage(name: Routes.FAV, page: () => FavScreen(), binding: FavBinding()),
  ];
}
