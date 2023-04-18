import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/pages/create_recipe/create_recipe_controller.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/decoration/textfield_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';
import 'package:receipt_app/src/presentation/widgets/textfields/form_widget.dart';

class AddDataTiListSheet extends StatefulWidget {
  final bool isIngredient;
  final String title;
  const AddDataTiListSheet(
      {Key? key, required this.isIngredient, required this.title})
      : super(key: key);

  @override
  State<AddDataTiListSheet> createState() => _AddDataTiListSheetState();
}

class _AddDataTiListSheetState extends State<AddDataTiListSheet> {
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  bool isDescChanged = false;

  @override
  void initState() {
    descCtrl.addListener(() {
      if (descCtrl.text.trim().isNotEmpty) {
        setState(() {
          isDescChanged = true;
        });
      } else {
        setState(() {
          isDescChanged = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 50.h),
      decoration: BoxDecoration(
        color: AppColor.whiteSnow,
        boxShadow: AppGlobalDecoration.globalShadow,
        borderRadius: AppGlobalDecoration.globalRadiusOnlyTop,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// drag indidicator
            Center(
              child: Container(
                width: 200.w,
                height: 5.h,
                decoration: BoxDecoration(
                    borderRadius: AppGlobalDecoration.globalRadius,
                    color: AppColor.blackHardness25),
              ),
            ),
            50.verticalSpace,

            /// title
            TextWidget(
              'Agregar ${widget.title}',
              font: AppFont.h1,
              color: AppColor.blackHardness,
            ),
            30.verticalSpace,

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      if (!widget.isIngredient)
                        TextFieldDecoration(
                          child: Row(
                            children: [
                              Expanded(
                                child: FormWidget(
                                  maxLines: 5,
                                  isOutline: false,
                                  controller: titleCtrl,
                                  hint: 'Titulo (opcional)',
                                  bordeColor: Colors.transparent,
                                  keyboardType: TextInputType.text,
                                  inputAction: TextInputAction.done,
                                ),
                              ),
                            ],
                          ),
                        ),
                      20.verticalSpace,
                      TextFieldDecoration(
                        child: Row(
                          children: [
                            Expanded(
                              child: FormWidget(
                                maxLines: 5,
                                isOutline: false,
                                controller: descCtrl,
                                hint: 'Descripción',
                                bordeColor: Colors.transparent,
                                keyboardType: TextInputType.text,
                                inputAction: TextInputAction.next,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                40.horizontalSpace,
                AnimatedOnTapWidget(
                  enabled: isDescChanged,
                  onTap: () {
                    if (widget.isIngredient) {
                      CreateRecipeController.inst
                          .addIngredient(name: descCtrl.text.trim());
                    } else {
                      CreateRecipeController.inst.addStep(
                          title: titleCtrl.text.trim(),
                          name: descCtrl.text.trim());
                    }
                  },
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.energy,
                      boxShadow: AppGlobalDecoration.globalShadow,
                      borderRadius: AppGlobalDecoration.globalRadius,
                    ),
                    child: const Icon(
                      AppIcon.send,
                      color: AppColor.whiteSnow,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
