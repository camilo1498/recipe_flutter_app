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

class AddRecipeUrlWidget extends StatelessWidget {
  const AddRecipeUrlWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateRecipeController>(
        id: 'add_url',
        builder: (ctrl) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// url field
                TextFieldDecoration(
                  child: SizedBox(
                    height: 100.h,
                    child: Row(
                      children: [
                        /// url
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                TextWidget(
                                  ctrl.recipeUrlCtrl.text.trim().isNotEmpty
                                      ? ctrl.recipeUrlCtrl.text
                                      : 'https://www.youtube.com/...',
                                  color:
                                      ctrl.recipeUrlCtrl.text.trim().isNotEmpty
                                          ? AppColor.blackHardness
                                          : AppColor.blackHardness50,
                                  font: AppFont.body,
                                )
                              ],
                            ),
                          ),
                        ),
                        20.horizontalSpace,

                        /// paste or delete icon
                        AnimatedOnTapWidget(
                          onTap: ctrl.recipeUrlCtrl.text.trim().isNotEmpty
                              ? ctrl.clearUrlField
                              : ctrl.pasteUrlFromClipboard,
                          child: ctrl.recipeUrlCtrl.text.trim().isNotEmpty
                              ? SizedBox(
                                  width: 80.w,
                                  height: 80.w,
                                  child: const Icon(
                                    AppIcon.delete,
                                    size: 30,
                                    color: AppColor.energy,
                                  ),
                                )
                              : TextWidget(
                                  'Pegar',
                                  font: AppFont.bodyBold,
                                  color: AppColor.energy,
                                ),
                        )
                      ],
                    ),
                  ),
                ),

                if (ctrl.invalidUrl)
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: TextWidget(
                      'Url invalida',
                      font: AppFont.captionBold,
                      color: AppColor.redAlert,
                    ),
                  )
              ],
            ));
  }
}
