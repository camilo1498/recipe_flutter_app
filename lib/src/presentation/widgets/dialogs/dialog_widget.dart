import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:receipt_app/src/core/extensions/context_extension.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';

import '../../../core/global/app_colors_global.dart';
import '../buttons/button_widget.dart';
import '../text/text_widget.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({
    Key? key,
    this.title = 'UPS!',
    this.description = 'Tenemos problemas!',
    this.exitText = 'Cancelar',
    this.acceptText = 'ACEPTAR',
    this.isLoad,
    this.onTapAccept,
    this.onTapExit,
  }) : super(key: key);

  final String title;
  final String description;
  final String exitText;
  final String acceptText;
  final RxBool? isLoad;
  final VoidCallback? onTapAccept;
  final VoidCallback? onTapExit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.whiteSnow,
      insetPadding: EdgeInsets.symmetric(horizontal: context.maxWidth * .08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        constraints:
            context.isMobile ? null : const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(24), // Padding vertical for the column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              font: AppFont.bodyBold,
              color: AppColor.blackHardness,
            ),
            const SizedBox(height: 16),
            TextWidget(
              description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              color: AppColor.blackHardness,
              font: AppFont.body,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (onTapExit != null)
                  Expanded(
                    child: ButtonWidget(
                      text: exitText,
                      onTap: onTapExit,
                      background: Colors.transparent,
                      textColor: AppColor.blackHardness,
                    ),
                  ),
                if (onTapExit != null) const SizedBox(width: 12),
                Expanded(
                  child: ButtonWidget(
                    text: acceptText,
                    onTap: onTapAccept,
                    font: AppFont.bodyBold,
                    gradient: const LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: AppColor.evolutionGradient,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> show({
    Widget? child,
    String title = 'UPS!',
    String description = 'Tenemos algunos problemas!',
    String acceptText = 'ACEPTAR',
    String exitText = 'Cancelar',
    bool barrierDismissible = true,
    VoidCallback? onTapAccept,
    VoidCallback? onTapExit,
    VoidCallback? whenComplete,
  }) async {
    if (Get.isSnackbarOpen) return;

    return await Get.dialog<void>(
      child ??
          DialogWidget(
            title: title,
            description: description,
            exitText: exitText,
            acceptText: acceptText,
            onTapAccept: onTapAccept,
            onTapExit: onTapExit,
          ),
      barrierDismissible: barrierDismissible,
      barrierColor: AppColor.blackHardness.withOpacity(0.5),
    ).whenComplete(() => whenComplete != null ? whenComplete() : null);
  }

  static Future<void> showReactive({
    required RxBool isLoad,
    String title = 'UPS!',
    String description = 'Tenemos algunos problemas!',
    String acceptText = 'ACEPTAR',
    String exitText = 'Cancelar',
    bool barrierDismissible = true,
    VoidCallback? onTapAccept,
    VoidCallback? onTapExit,
    VoidCallback? whenComplete,
  }) async {
    if (Get.isSnackbarOpen) return;

    return await Get.dialog<void>(
      DialogWidget(
        title: title,
        description: description,
        exitText: exitText,
        acceptText: acceptText,
        onTapAccept: onTapAccept,
        onTapExit: onTapExit,
        isLoad: isLoad,
      ),
      barrierDismissible: barrierDismissible,
      barrierColor: AppColor.blackHardness.withOpacity(0.5),
    ).whenComplete(() => whenComplete != null ? whenComplete() : null);
  }
}
