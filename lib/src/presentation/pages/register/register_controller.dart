import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/data/source/http/data_post_service.dart';
import 'package:receipt_app/src/presentation/pages/login/login_controller.dart';
import 'package:receipt_app/src/presentation/routes/app_routes.dart';
import 'package:receipt_app/src/presentation/widgets/dialogs/dialog_widget.dart';

class RegisterController extends GetxController {
  /// instances
  final DataPostService _dataPostService = DataPostService();

  /// controller
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController lastnameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  /// Variables
  final FocusNode nameNode = FocusNode();
  final FocusNode emailNode = FocusNode();
  final FocusNode lastnameNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  /// variables
  bool loading = false;
  bool enableButton = false;
  bool hidePassword = true;

  /// Hacer visible la contraseña
  onTapShowPassword() {
    hidePassword = !hidePassword;
    update(['hide']);
  }

  /// Cambiar al proximo form
  void nextForm({required FocusNode current, required FocusNode next}) {
    current.unfocus();
    next.requestFocus();
  }

  /// Validar campos
  validateFields() {
    emailCtrl.text.isEmail &&
            passwordCtrl.text.trim().isNotEmpty &&
            nameCtrl.text.trim().isNotEmpty &&
            lastnameCtrl.text.trim().isNotEmpty
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

  onTapSignUp() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (enableButton) {
      /// show loading widget
      loading = true;
      hidePassword = true;
      update(['loading', 'hide']);

      /// send register http query to backend
      await _dataPostService
          .registerUser(
        name: nameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
        lastname: lastnameCtrl.text.trim(),
      )
          .then((res) {
        if (res['success'] == true) {
          /// go to main page
          Get.offAllNamed(AppRoutes.mainPage);
        } else {
          LoginController.inst.clearLocalStorage(res);
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
}
