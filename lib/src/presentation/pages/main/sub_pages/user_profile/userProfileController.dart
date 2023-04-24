import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/global_controller.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/data/models/user/user_model.dart';
import 'package:receipt_app/src/data/source/http/data_put_service.dart';
import 'package:receipt_app/src/data/source/local_storage/hive_service.dart';
import 'package:receipt_app/src/presentation/pages/main/main_controller.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/user_profile/sheets/change_pwd_sheet.dart';
import 'package:receipt_app/src/presentation/routes/app_routes.dart';
import 'package:receipt_app/src/presentation/widgets/dialogs/dialog_widget.dart';

class UserProfileController extends GetxController {
  /// instances
  final HiveService hiveService = GlobalController.inst.hiveServices;
  final DataPutService _dataPutService = DataPutService();

  /// controller
  final TextEditingController pswCtrl = TextEditingController();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController lastnameCtrl = TextEditingController();

  /// Variables
  final FocusNode nameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode lastnameNode = FocusNode();

  /// variables
  bool loading = false;
  bool enableButton = false;
  bool showPassword = true;
  bool updateData = false;
  bool hidePassword = true;

  @override
  void onInit() {
    _setData(hiveService.profile);
    super.onInit();
  }

  _setData(UserModel? profile) {
    nameCtrl.text = profile?.name ?? '';
    lastnameCtrl.text = profile?.lastname ?? '';
    emailCtrl.text = profile?.email ?? '';
  }

  /// Cambiar al proximo form
  nextForm({required FocusNode current, required FocusNode next}) {
    current.unfocus();
    next.requestFocus();
  }

  /// Valida los formaulario dependiendo del [SignupValidator]
  String? validateForm({bool isPassword = false, required String? str}) {
    return isPassword
        ? str != null && str.isNotEmpty
            ? null
            : 'Ingrese su contraseña'
        : str != null && str.isEmail
            ? null
            : 'Escribe un correo valido';
  }

  /// Validar campos
  validateFields() {
    if ((emailCtrl.text.isEmail &&
            nameCtrl.text.trim().isNotEmpty &&
            lastnameCtrl.text.trim().isNotEmpty) ||
        nameCtrl.text.trim() != hiveService.profile?.name ||
        lastnameCtrl.text.trim() != hiveService.profile?.lastname ||
        emailCtrl.text.trim() != hiveService.profile?.email) {
      enableButton = true;
      update(['profile_page']);
    } else {
      enableButton = false;
      update(['profile_page']);
    }
  }

  /// edit data button action
  onTapUpdateData() {
    updateData = !updateData;
    _setData(hiveService.profile);
    update(['profile_page']);
  }

  /// update data button action
  sendDataToBackend() async {
    if (enableButton) {
      /// init loading
      MainController.inst.loading.value = true;
      loading = true;
      updateData = false;
      update(['profile_page']);

      /// update data
      await _dataPutService
          .updateUserData(
              name: nameCtrl.text.trim(),
              lastname: lastnameCtrl.text.trim(),
              email: emailCtrl.text.trim())
          .then((res) {
        if (res['success'] == true) {
          /// success dialog
          _setData(res['data']);
          AppUtils.snackBar(
              title: 'Actualización',
              menssage: 'Datos '
                  'actualizados '
                  'correctamente');
        } else {
          /// error dialog
          DialogWidget.show(
            acceptText: 'Aceptar',
            title: 'Actualización',
            description: 'Error al actualizar los datos',
            onTapAccept: () => Get.back(),
          );
        }
      }).whenComplete(() {
        /// close loading
        MainController.inst.loading.value = false;
        loading = false;
        update(['profile_page']);
      });
    }
  }

  openPswSheet() {
    Get.bottomSheet(const ChangePwdSheet(), backgroundColor: Colors.transparent)
        .whenComplete(() {});
  }

  updatePassword() async {
    if (pswCtrl.text.trim().isNotEmpty) {
      Get.back();
      MainController.inst.loading.value = true;
      loading = true;
      update(['profile_page']);

      await _dataPutService
          .updatePassword(password: pswCtrl.text.trim())
          .then((res) async {
        print(res);
        if (res['success'] == true) {
          // await logout();
        } else {
          AppUtils.snackBar(
              title: 'Cambiar contraseña',
              menssage: res['message'],
              duration: 5);
        }
      }).whenComplete(() {
        MainController.inst.loading.value = false;
        loading = false;
        update(['profile_page']);
      });
    }
  }

  /// Hacer visible la contraseña
  onTapShowPassword() {
    hidePassword = !hidePassword;
    update(['hide']);
  }

  /// logout
  logout() async {
    await hiveService.logout();
    Get.offAllNamed(AppRoutes.loginPage);
  }
}
