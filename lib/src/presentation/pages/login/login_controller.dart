import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/data/source/http/data_get_service.dart';
import 'package:receipt_app/src/data/source/http/data_post_service.dart';
import 'package:receipt_app/src/data/source/local_storage/hive_service.dart';
import 'package:receipt_app/src/presentation/pages/login/sheets/change_pwd_sheet.dart';
import 'package:receipt_app/src/presentation/routes/app_routes.dart';
import 'package:receipt_app/src/presentation/widgets/dialogs/dialog_widget.dart';

class LoginController extends GetxController {
  static LoginController get inst => Get.find<LoginController>();

  /// instances
  final DataGetService _dataGetService = DataGetService();
  final DataPostService _dataPostService = DataPostService();
  final HiveService _hiveService = HiveService();

  /// controller
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final restoreCtrl = TextEditingController();

  /// Variables
  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  /// variables
  bool loading = false;
  bool enableButton = false;
  bool hidePassword = true;

  /// Hacer visible la contraseña
  onTapShowPassword() {
    hidePassword = !hidePassword;
    update(['hide']);
  }

  /// Ir a la pagina de registro
  void onTapSignUpButton() async {
    FocusManager.instance.primaryFocus?.unfocus();
    return Get.toNamed(AppRoutes.registerPage);
  }

  /// Cambiar al proximo form
  void nextForm({required FocusNode current, required FocusNode next}) {
    current.unfocus();
    next.requestFocus();
  }

  /// Validar campos
  validateFields() {
    emailCtrl.text.isEmail && passwordCtrl.text.isNotEmpty
        ? enableButton = true
        : enableButton = false;
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

  /// sign in
  onTapLoginButton() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (enableButton) {
      /// show loading widget
      loading = true;
      hidePassword = true;
      update(['loading', 'hide']);

      /// send login http query to backend
      await _dataGetService
          .getLoginToken(
              email: emailCtrl.text.trim(), password: passwordCtrl.text.trim())
          .then((res) async {
        if (res['success'] == true) {
          /// send user profile http query to backend
          await _dataGetService.getUserProfile().then((res) async {
            if (res['success'] == true) {
              /// go to main page
              Get.offAllNamed(AppRoutes.mainPage);
            } else {
              /// show error dialog
              await clearLocalStorage(res);
            }
          });
        } else {
          /// show error dialog
          await clearLocalStorage(res);
        }
      }).whenComplete(() {
        /// hide loading widget
        loading = false;
        update(['loading']);
      });
    } else {
      DialogWidget.show(
        acceptText: 'Aceptar',
        title: 'Validación',
        description: 'Debes llenar todos los campos',
        onTapAccept: () => Get.back(),
      );
    }
  }

  /// open send restore password
  openRestorePswDialog() {
    Get.bottomSheet(const SendPswEmailSheet()).whenComplete(() {});
  }

  updatePassword() async {
    if (restoreCtrl.text.trim().isNotEmpty) {
      Get.back();
      loading = true;
      update(['loading']);

      await _dataPostService
          .updateFromEmail(email: restoreCtrl.text.trim())
          .then((res) async {
        if (res['success'] == true) {
          DialogWidget.show(
              title: 'Recuperar contraseña',
              description: res['message'],
              onTapAccept: () => Get.back());
        } else {
          AppUtils.snackBar(
              title: 'Cambiar contraseña',
              menssage: res['message'],
              duration: 5);
        }
      }).whenComplete(() {
        loading = false;
        restoreCtrl.clear();
        update(['loading']);
      });
    }
  }

  /// clear local storage
  clearLocalStorage(res) async {
    /// show error dialog
    DialogWidget.show(
      acceptText: 'Aceptar',
      title: 'Error al iniciar sesión',
      description: res['message'],
      onTapAccept: () => Get.back(),
    );

    /// clear local storage
    await _hiveService.logout();
  }
}
