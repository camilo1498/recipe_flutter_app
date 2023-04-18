import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/global_controller.dart';
import 'package:receipt_app/src/presentation/routes/app_routes.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get inst => Get.find();

  @override
  void onReady() async {
    await 2.seconds.delay();
    final id = GlobalController.inst.profile?.id ?? '';
    final token = GlobalController.inst.hiveServices.token;
    id.isNotEmpty && token.isNotEmpty
        ? Get.offNamed(AppRoutes.mainPage)
        : Get.offNamed(AppRoutes.loginPage);
    super.onReady();
  }
}
