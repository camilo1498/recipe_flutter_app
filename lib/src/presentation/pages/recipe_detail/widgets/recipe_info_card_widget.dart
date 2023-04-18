import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class RecipeInfoCardWidget extends StatelessWidget {
  final RecipeDetailController ctrl;
  const RecipeInfoCardWidget({Key? key, required this.ctrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
            color: AppColor.whiteSnow,
            boxShadow: AppGlobalDecoration.globalShadow,
            borderRadius: AppGlobalDecoration.globalRadius),
        child: Row(
          children: [
            _infoCard(
                icon: AppIcon.stats,
                title: 'Dificultad',
                subtitle: ctrl.recipeData!.difficulty.name),
            Container(
              height: 60.h,
              width: 2.w,
              color: AppColor.blackHardness25,
            ),
            _infoCard(
                icon: AppIcon.user,
                title: 'Porciones',
                subtitle: ctrl.recipeData!.portions.toString()),
            Container(
              height: 60.h,
              width: 2.w,
              color: AppColor.blackHardness25,
            ),
            _infoCard(
                icon: AppIcon.time,
                title: 'Total',
                subtitle: '${ctrl.recipeData!.preparationTime} Min')
          ],
        ),
      ),
    );
  }

  Widget _infoCard(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: AppColor.energy,
          ),
          TextWidget(
            title,
            font: AppFont.captionBold,
            color: AppColor.blackHardness,
          ),
          TextWidget(
            subtitle,
            font: AppFont.caption,
            color: AppColor.blackHardness,
          )
        ],
      ),
    );
  }
}
