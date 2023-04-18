import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/presentation/pages/main/main_controller.dart';
import 'package:receipt_app/src/presentation/pages/main/widgets/bottom_navbar_widget.dart';
import 'package:receipt_app/src/presentation/routes/app_pages.dart';
import 'package:receipt_app/src/presentation/routes/app_routes.dart';
import 'package:receipt_app/src/presentation/widgets/inddicators/loading_indicator.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      id: 'main_page',
      builder: (ctrl) => WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: AppColor.background,
              body: Column(
                children: [
                  Expanded(
                    child: Navigator(
                      key: Get.nestedKey(0),
                      initialRoute: AppRoutes.homePage,
                      onGenerateRoute: (route) => AppPages.mainPages(route),
                    ),
                  ),

                  /// bottom bar
                ],
              ),
              bottomNavigationBar: GetBuilder<MainController>(
                id: 'change_page',
                builder: (ctrl) => BottomNavbarWidget(
                    background: AppColor.whiteSnow,
                    selectItem: ctrl.selectItemBottomNav,
                    items: [
                      BottomNavBarWidgetItem(
                          icon: AppIcon.home,
                          onTap: (i) => ctrl.nextPage(
                              indexPag: i, route: AppRoutes.homePage)),
                      BottomNavBarWidgetItem(
                          icon: Icons.favorite_outlined,
                          onTap: (i) => ctrl.nextPage(
                              indexPag: i, route: AppRoutes.savedRecipes)),
                      BottomNavBarWidgetItem(
                          icon: AppIcon.user,
                          onTap: (i) => ctrl.nextPage(
                              indexPag: i, route: AppRoutes.userProfile))
                    ]),
              ),
            ),
            Obx(() => MainController.inst.loading.value
                ? const LoadingIndicator()
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}
