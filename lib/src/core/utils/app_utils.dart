import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class AppUtils {
  /// Siempre esta comprobando el estado de conexion WIFI, DATOS MOBILES,..etc

  /// No deja colocar espacios en un formulario
  static List<TextInputFormatter> get withoutSpaces => [
        FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
      ];

  static StreamSubscription<ConnectivityResult> listenInternet(
    ValueChanged<ConnectivityResult>? onData,
  ) {
    return Connectivity().onConnectivityChanged.listen(
          onData,
          onError: (e) => debugPrint(".- Error al verificar el internet: $e"),
        );
  }

  /// Retorna true si hay internet
  static Future<bool> isInternet({bool showSnackbar = true}) async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
      if (showSnackbar) {
        snackBar(
          title: 'UPS',
          menssage: 'Verifica tu conexión a internet',
          duration: 3,
        );
      }
      return false;
    } on SocketException {
      if (showSnackbar) {
        snackBar(
          title: 'UPS',
          menssage: 'Verifica tu conexión a internet',
          duration: 3,
        );
      }
      return false;
    }
  }

  /// show snackbar
  static SnackbarController? snackBar({
    String title = "Mensaje!",
    required String menssage,
    int duration = 2,
  }) {
    if (Get.isSnackbarOpen) return null;
    return Get.snackbar(
      title,
      menssage,
      titleText: TextWidget(
        title,
        color: AppColor.whiteSnow,
        font: AppFont.bodyBold,
        fontWeight: FontWeight.bold,
      ),
      messageText: TextWidget(
        menssage,
        color: AppColor.whiteSnow,
        font: AppFont.body,
      ),
      backgroundColor: AppColor.blackHardness.withOpacity(.75),
      duration: Duration(seconds: duration),
    );
  }

  /// global text style
  static TextStyle textStyle({
    required BuildContext context,
    AppFont? font,
    FontWeight fontWeight = FontWeight.normal,
    Color color = AppColor.blackHardness,
    double? size,
  }) {
    return TextStyle(
        fontFamily: font != null ? font.family : AppFont.body.family,
        fontWeight: fontWeight,
        color: color,
        fontSize: font != null ? 14 : size ?? font?.size);
  }
}
