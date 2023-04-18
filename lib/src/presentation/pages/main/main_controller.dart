import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MainController extends GetxController {
  static MainController get inst => Get.find<MainController>();
  int selectItemBottomNav = 0;
  RxBool loading = false.obs;

  nextPage({required int indexPag, required String route}) async {
    if (selectItemBottomNav == indexPag) return;
    selectItemBottomNav = indexPag;
    update(['change_page']);
    return Get.offAllNamed(route, id: 0);
  }

  @override
  void onInit() async {
    /// request device permissions
    await Permission.manageExternalStorage.request();
    super.onInit();
  }
}
