import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';

class GlobalBackButton extends StatelessWidget {
  final Function() onClickButton;

  const GlobalBackButton({Key? key, required this.onClickButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOnTapWidget(
      onTap: onClickButton,
      child: Container(
        height: 120.w,
        width: 120.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: AppGlobalDecoration.globalRadius,
          color: AppColor.blackHardness10,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 0.5,
              spreadRadius: 0.5,
              offset: const Offset(0, 0.5),
            )
          ],
        ),
        padding: EdgeInsets.only(right: 5.w),
        child: const Icon(
          AppIcon.back,
          color: AppColor.blackHardness,
        ),
      ),
    );
  }
}
