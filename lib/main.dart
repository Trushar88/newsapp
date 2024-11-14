// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:newsapp/app/config/app_strings.dart';
import 'package:newsapp/routes/bindings/init_binding.dart';
import 'package:newsapp/routes/app_pages.dart';
import 'package:newsapp/routes/app_routes.dart';
import 'package:newsapp/theme/app_theme.dart';
import 'package:newsapp/theme/theme_service.dart';
import 'package:newsapp/app/config/app_colors.dart';
import 'package:newsapp/app/service/local_storage.dart';

void main() async {
  await initServices();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: APPCOLOR.PRIMARYCOLOR, // status bar color
  ));
  runApp(
    MyApp(),
  );
}

initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  await Get.putAsync(() => LocalStorageService().init());
}

class MyApp extends StatelessWidget {
  dynamic analytics;
  dynamic observer;
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.white38,
      overlayWholeScreen: true,
      overlayWidgetBuilder: (_) {
        return const PopScope(
          canPop: false,
          child: Center(child: CircularProgressIndicator()),
        );
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        themeMode: ThemeService().theme,
        darkTheme: Themes.dark,
        getPages: AppPages.pages,
        initialBinding: InitBinding(),
        title: APPSTRING.APP_NAME,
        initialRoute: Routes.INITIAL,
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
