import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';

class TextFieldDecoration extends StatelessWidget {
  final Widget child;
  const TextFieldDecoration({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      decoration: BoxDecoration(
          borderRadius: AppGlobalDecoration.globalRadius,
          border: Border.all(color: AppColor.blackHardness50)),
      child: child,
    );
  }
}
