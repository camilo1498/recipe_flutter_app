import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/pages/create_recipe/create_recipe_controller.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/decoration/textfield_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class AddIngredientsWidget extends StatelessWidget {
  const AddIngredientsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateRecipeController>(
      id: 'ingredients',
      builder: (ctrl) => Column(
        children: [
          AnimatedOnTapWidget(
            onTap: ctrl.openAddIngredient,
            child: Row(
              children: [
                Expanded(
                  child: TextFieldDecoration(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: TextWidget(
                        'Agregar ingredientes',
                        font: AppFont.body,
                        color: AppColor.blackHardness50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          20.verticalSpace,

          /// list of ingredients
          ...ctrl.listOfIngredients.map((ingredient) {
            final int index = ctrl.listOfIngredients.indexOf(ingredient);
            return Padding(
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
                  20.horizontalSpace,

                  /// remove ingredient from list
                  AnimatedOnTapWidget(
                    onTap: () => ctrl.deleteIngredient(index),
                    child: SizedBox(
                      width: 80.w,
                      height: 80.w,
                      child: const Icon(
                        AppIcon.delete,
                        size: 30,
                        color: AppColor.energy,
                      ),
                    ),
                  )
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
