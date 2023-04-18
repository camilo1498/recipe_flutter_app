import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_type_model.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class RecipeFilterCardWidget extends StatelessWidget {
  final RecipeTypeModel filter;
  final int index;
  final int selectedIndex;
  final Function(int index) onSelected;
  const RecipeFilterCardWidget(
      {Key? key,
      required this.filter,
      required this.index,
      required this.selectedIndex,
      required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOnTapWidget(
      onTap: () => onSelected(index),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          decoration: BoxDecoration(
              borderRadius: AppGlobalDecoration.globalRadius,
              color: selectedIndex == index
                  ? AppColor.blackHardness
                  : AppColor.background,
              border: Border.all(color: AppColor.blackHardness)),
          child: TextWidget(
            filter.name,
            font: AppFont.bodyBold,
            color: selectedIndex == index
                ? AppColor.whiteSnow
                : AppColor.blackHardness,
          ),
        ),
      ),
    );
  }
}
