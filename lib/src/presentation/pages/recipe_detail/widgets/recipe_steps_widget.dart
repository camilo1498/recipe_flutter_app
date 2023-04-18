import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class RecipeStepsWidget extends StatelessWidget {
  final RecipeDetailController ctrl;
  const RecipeStepsWidget({Key? key, required this.ctrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...ctrl.recipeData!.steps.map((step) {
          final int index = ctrl.recipeData!.steps.indexOf(step);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// title
                Row(
                  children: [
                    /// step
                    TextWidget(
                      'PASO ${index + 1}',
                      font: AppFont.h3,
                      color: AppColor.energy,
                    ),

                    /// step description
                    if (step.title.isNotEmpty)
                      Expanded(
                          child: TextWidget(
                        ':  ${step.title}'.toUpperCase(),
                        font: AppFont.h3,
                        color: AppColor.energy,
                      ))
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// dot indicator
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Container(
                        width: 20.w,
                        height: 20.w,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.energy),
                      ),
                    ),
                    40.horizontalSpace,

                    /// ingredient title
                    Expanded(
                      child: TextWidget(
                        step.description,
                        font: AppFont.body,
                        color: AppColor.blackHardness,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        })
      ],
    );
  }
}
