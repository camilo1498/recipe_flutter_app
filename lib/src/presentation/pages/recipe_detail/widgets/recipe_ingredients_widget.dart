import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class RecipeIngredientsWidget extends StatelessWidget {
  final RecipeDetailController ctrl;
  const RecipeIngredientsWidget({Key? key, required this.ctrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...ctrl.recipeData!.ingredients.map((ingredient) => Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                children: [
                  /// dot indicator
                  Container(
                    width: 15.w,
                    height: 15.w,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.energy),
                  ),
                  40.horizontalSpace,

                  /// ingredient title
                  Expanded(
                    child: TextWidget(
                      ingredient,
                      font: AppFont.body,
                      color: AppColor.blackHardness,
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
