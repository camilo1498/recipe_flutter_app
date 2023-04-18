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
    // await checkPermission();
    super.onInit();
  }

  // Future<bool> checkPermission() async {
  //   ///For Check permission..
  //   await Permission.manageExternalStorage.request();
  //   if (Platform.isAndroid
  //       ? !await requestPermission(Permission.storage) &&
  //           !await requestPermission(Permission.manageExternalStorage)
  //       : !await requestPermission(Permission.storage)) {
  //     await Get.dialog(CupertinoAlertDialog(
  //       title: const Text("Photos & Videos permission"),
  //       content: const Text(
  //           " Photos & Videos permission should be granted to connect with device, would you like to go to app settings to give Bluetooth & Location permissions?"),
  //       actions: <Widget>[
  //         TextButton(
  //             child: const Text('No thanks'),
  //             onPressed: () {
  //               Get.back();
  //             }),
  //         TextButton(
  //             child: const Text('Ok'),
  //             onPressed: () async {
  //               Get.back();
  //               await openAppSettings();
  //             })
  //       ],
  //     ));
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
  //
  // Future<bool> requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }
}
