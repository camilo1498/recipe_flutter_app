import 'package:flutter/cupertino.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';

class AppGlobalDecoration {
  /// Global_Borders
  static final BorderRadius globalRadius = BorderRadius.circular(10);
  static const BorderRadius globalRadiusOnlyBottom = BorderRadius.only(
      bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12));
  static const BorderRadius globalRadiusOnlyTop = BorderRadius.only(
      topLeft: Radius.circular(10), topRight: Radius.circular(10));

  /// box shadows
  static final List<BoxShadow> globalShadow = [
    BoxShadow(
        color: AppColor.blackHardness.withOpacity(0.2),
        blurRadius: 0.5,
        spreadRadius: 0.5,
        offset: const Offset(0, 0.7))
  ];

  /* Bold font style
The following request a "Color" to add color to a TextStyle
*/

  static TextStyle bold16Text(
      {required Color color, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
        fontSize: 16.0,
        fontFamily: fontFamily ?? 'lexendBold',
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color);
  }

  static TextStyle bold18Text(
      {required Color color, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
        fontSize: 20.0,
        fontFamily: fontFamily ?? 'lexendBold',
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color);
  }

  static TextStyle bold20Text(
      {required Color color, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
        fontFamily: fontFamily ?? "lexendbold",
        fontSize: 25.0,
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color);
  }

  static TextStyle bold25Text(
      {required Color color, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
        fontSize: 25.0,
        fontFamily: fontFamily ?? 'lexendBold',
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color);
  }

  static TextStyle bold72Text(
      {required Color color, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
        fontSize: 72.0,
        fontFamily: fontFamily ?? 'lexendBold',
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: color);
  }

/* Book font style
The following request a "Color" to add color to a TextStyle
*/

  static TextStyle book16Text(
      {required Color color, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
        fontSize: 16.0,
        fontFamily: fontFamily ?? 'lexendRegular',
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color);
  }

  static TextStyle book17Text(
      {required Color color, FontWeight? fontWeight, String? fontFamily}) {
    return TextStyle(
        fontSize: 17.0,
        fontFamily: fontFamily ?? 'lexendRegular',
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color);
  }

  static TextStyle textStyle(
      {Color? color,
      FontWeight? fontWeight,
      double? size,
      String? fontFamily}) {
    return TextStyle(
        fontSize: size ?? 12.0,
        fontFamily: fontFamily ?? 'GothamLight',
        fontStyle: FontStyle.normal,
        fontWeight: fontWeight ?? FontWeight.w300,
        color: color ?? AppColor.blackHardness);
  }

  /// span without bold text
  static TextSpan subTitleSpan({required subTitle, Color? textColor}) {
    return TextSpan(
        text: subTitle,
        style: textStyle(
            color: textColor ?? AppColor.whiteSnow,
            fontWeight: FontWeight.w400,
            size: 15));
  }

  /// span with bold text
  static TextSpan subTitleBoldSpan({required subTitle, Color? textColor}) {
    return TextSpan(
        text: subTitle,
        style: textStyle(
            color: textColor ?? AppColor.whiteSnow,
            fontWeight: FontWeight.w600,
            fontFamily: 'GothamMedium',
            size: 15));
  }
}
