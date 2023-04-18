import 'package:flutter/material.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.data, {
    Key? key,
    this.font,
    this.fontWeight = FontWeight.normal,
    this.size,
    this.color,
    this.enableShadow = false,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.lineHeight,
    this.textDecoration,
    this.textScaleFactor,
  }) : super(key: key);

  final AppFont? font;
  final bool enableShadow;
  final String data;
  final FontWeight fontWeight;
  final double? size;
  final Color? color;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? lineHeight;
  final TextDecoration? textDecoration;

  /// **Tamaños del TextScaleFactor**
  ///
  /// [ 1.56 = 25px ] [ 1.25 = 20px ] [ 1.0 = 16px ] [ 0.95 = 15px ] [ 0.9 = 14px ] [ 0.81 = 13px ]
  ///
  final double? textScaleFactor;

  @override
  Widget build(BuildContext context) {
    final styleDefault = Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontFamily: font != null ? font?.family : AppFont.body.family,
        fontWeight: fontWeight,
        color: color,
        height: lineHeight,
        decoration: textDecoration,
        shadows: enableShadow
            ? [
                const Shadow(
                  color: AppColor.blackHardness,
                  offset: Offset(0, 1),
                  blurRadius: 3,
                )
              ]
            : null,
        fontSize:
            font != null ? size ?? font?.size : size ?? AppFont.body.size);
    return Text(
      data,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      style: style ?? styleDefault,
    );
  }
}
