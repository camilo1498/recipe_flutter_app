import 'package:flutter/material.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';

import '../../../core/global/app_colors_global.dart';
import '../animations/animated_onTap_widget.dart';
import '../text/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    this.text = 'Boton',
    this.textColor,
    this.background,
    this.gradient,
    this.borderColor,
    this.showShadow = false,
    this.shadowColor,
    this.font,
    this.padding = const EdgeInsets.symmetric(horizontal: 4),
    this.minHeight = 50,
    this.minWidth = 0.0,
    this.borderRadius,
    this.onNullTextColor = AppColor.blackHardness50,
    this.onNullBackground = AppColor.blackHardness10,
    this.child,
    this.enable = true,
    this.width,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Color? textColor;
  final Color? background;
  final Gradient? gradient;
  final Color? borderColor;
  final bool showShadow;
  final Color? shadowColor;
  final AppFont? font;
  final EdgeInsetsGeometry padding;
  final double minHeight;
  final double minWidth;
  final BorderRadiusGeometry? borderRadius;
  final Color onNullTextColor;
  final Color onNullBackground;
  final Widget? child;
  final double? width;
  final bool enable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedOnTapWidget(
      enabled: onTap != null && enable ? true : false,
      onTap: onTap,
      child: Container(
        width: width,
        padding: padding,
        constraints: BoxConstraints(
          minHeight: minHeight,
          minWidth: minWidth,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          color:
              onTap != null ? background ?? AppColor.energy : onNullBackground,
          gradient: onTap != null ? gradient : null,
          border: borderColor != null ? Border.all(color: borderColor!) : null,
          boxShadow: [
            if (showShadow)
              BoxShadow(
                color: shadowColor ?? AppColor.blackHardness25,
                blurRadius: 4,
                offset: const Offset(0, 4),
              )
          ],
        ),
        child: child ??
            TextWidget(
              text,
              font: font ?? AppFont.button,
              color: onTap != null
                  ? textColor ?? AppColor.whiteSnow
                  : onNullTextColor,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
      ),
    );
  }
}
