import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/core/global/global_assets.dart';
import 'package:receipt_app/src/presentation/pages/splash_screen/splash_screen_contoller.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// initialize splash screen controller
    return GetBuilder<SplashScreenController>(
      builder: (ctrl) => Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// logo
            Hero(
              tag: 'initial_logo',
              transitionOnUserGestures: true,
              child: Center(
                child: SizedBox(
                  width: 450.w,
                  height: 450.w,
                  child: Image.asset(GlobalAssets.appLogo),
                ),
              ),
            ),
            20.verticalSpace,

            /// title
            TextWidget(
              'PanComido',
              font: AppFont.h1Italic,
            )
          ],
        ),
      ),
    );
  }
}
