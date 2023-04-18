import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/config/app_init_config.dart';
import 'package:receipt_app/src/core/global/global_controller.dart';
import 'package:receipt_app/src/presentation/routes/app_pages.dart';
import 'package:receipt_app/src/presentation/routes/app_routes.dart';

void main() async {
  /// init config
  await AppInitConfig.mainInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      init: GlobalController(),
      builder: (ctrl) => NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ScreenUtilInit(
            designSize: const Size(1080, 1920),
            builder: (_, __) => GetMaterialApp(
              title: 'PanComido',
              getPages: AppPages.pages,
              debugShowCheckedModeBanner: false,
              defaultTransition: Transition.fadeIn,
              initialRoute: AppRoutes.splashScreenPage,
              theme: ThemeData(primarySwatch: Colors.red),
              supportedLocales: const [Locale('en', 'US')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
