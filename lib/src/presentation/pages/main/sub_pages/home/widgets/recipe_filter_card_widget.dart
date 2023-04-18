import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_type_model.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/home_controller.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class RecipeFilterCardWidget extends StatelessWidget {
  final RecipeTypeModel filter;
  final int index;
  const RecipeFilterCardWidget(
      {Key? key, required this.filter, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOnTapWidget(
      onTap: () => HomeController.inst.onTapTypeFilter(index),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          decoration: BoxDecoration(
              borderRadius: AppGlobalDecoration.globalRadius,
              color: HomeController.inst.selectedTypeIndex == index
                  ? AppColor.blackHardness
                  : AppColor.background,
              border: Border.all(color: AppColor.blackHardness)),
          child: TextWidget(
            filter.name,
            font: AppFont.bodyBold,
            color: HomeController.inst.selectedTypeIndex == index
                ? AppColor.whiteSnow
                : AppColor.blackHardness,
          ),
        ),
      ),
    );
  }
}
