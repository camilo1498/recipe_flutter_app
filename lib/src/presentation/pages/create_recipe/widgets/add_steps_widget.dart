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

class AddStepsWidget extends StatelessWidget {
  const AddStepsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateRecipeController>(
      id: 'recipe_Steps',
      builder: (ctrl) => Column(
        children: [
          AnimatedOnTapWidget(
            onTap: ctrl.openAddStep,
            child: Row(
              children: [
                Expanded(
                  child: TextFieldDecoration(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: TextWidget(
                        'Agregar Pasos',
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
          ...ctrl.listOfSteps.map((step) {
            final int index = ctrl.listOfSteps.indexOf(step);
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
                      if (step['title'].isNotEmpty)
                        Expanded(
                            child: TextWidget(
                          ':  ${step['title']}'.toUpperCase(),
                          font: AppFont.h3,
                          color: AppColor.energy,
                          overflow: TextOverflow.ellipsis,
                        ))
                      else
                        const Expanded(child: SizedBox()),
                      20.horizontalSpace,

                      /// remove ingredient from list
                      AnimatedOnTapWidget(
                        onTap: () => ctrl.deleteStep(index),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// dot indicator
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Container(
                          width: 15.w,
                          height: 15.w,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: AppColor.energy),
                        ),
                      ),
                      40.horizontalSpace,

                      /// ingredient title
                      Expanded(
                        child: TextWidget(
                          step['description'],
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
      ),
    );
  }
}
