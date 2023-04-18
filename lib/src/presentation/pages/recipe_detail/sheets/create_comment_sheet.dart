import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/extensions/datetime_extension.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_loading.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/decoration/textfield_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/image_view/gallery_view.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';
import 'package:receipt_app/src/presentation/widgets/textfields/form_widget.dart';

class CreateCommentSheet extends StatelessWidget {
  const CreateCommentSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecipeDetailController>(
        id: 'create_comment',
        builder: (ctrl) => Container(
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
                    20.verticalSpace,

                    /// title
                    TextWidget(
                      'Crear comentario',
                      font: AppFont.h1,
                      color: AppColor.blackHardness,
                    ),

                    /// title current date
                    TextWidget(
                      '${DateTime.now().formatDate} ${DateTime.now().formatHour}',
                      font: AppFont.caption,
                      color: AppColor.blackHardness50,
                    ),
                    30.verticalSpace,

                    /// image picker
                    Row(
                      children: [
                        /// add image button
                        if (!ctrl.creatingComment)
                          AnimatedOnTapWidget(
                            onTap: ctrl.openGalleryPicker,
                            child: Container(
                              width: 130.w,
                              height: 130.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.blackHardness10,
                                boxShadow: AppGlobalDecoration.globalShadow,
                                borderRadius: AppGlobalDecoration.globalRadius,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: AppColor.blackHardness75,
                              ),
                            ),
                          ),
                        20.horizontalSpace,

                        /// pick images
                        Expanded(
                          child: Row(
                            children: [
                              /// selected images
                              if (ctrl.selectedImg.isNotEmpty)
                                GalleryView(
                                  imageFileList: ctrl.selectedImg
                                      .map((e) => File(e.path))
                                      .toList(),
                                  imageUrlList: const [],

                                  /// here only use url nor file
                                  width: 130.w,
                                  height: 130.w,
                                  isNetworkImg: false,
                                  heroTag: 'create_comment_image',
                                )

                              /// empty selected images title
                              else
                                Center(
                                  child: TextWidget(
                                    'No se han seleccionado imagenes',
                                    font: AppFont.caption,
                                    color: AppColor.blackHardness50,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                            ],
                          ),
                        ),
                        20.horizontalSpace,

                        /// clear selected images button (icon)
                        if (ctrl.selectedImg.isNotEmpty &&
                            !ctrl.creatingComment)
                          AnimatedOnTapWidget(
                            onTap: ctrl.deleteSelectedImg,
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
                    30.verticalSpace,

                    /// text field - create comment button
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldDecoration(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Row(
                                children: [
                                  /// text field
                                  Expanded(
                                    child: FormWidget(
                                      maxLines: 5,
                                      isOutline: false,
                                      hint: 'Escribir comentario',
                                      onChanged: ctrl.onChangedText,
                                      enabled: !ctrl.creatingComment,
                                      bordeColor: Colors.transparent,
                                      keyboardType: TextInputType.text,
                                      inputAction: TextInputAction.done,
                                      controller: ctrl.commentTxtController,
                                    ),
                                  ),
                                  20.horizontalSpace,

                                  /// send button
                                  if (!ctrl.creatingComment)
                                    AnimatedOnTapWidget(
                                      enabled: ctrl.validatedFields ||
                                          ctrl.selectedImg.isNotEmpty,
                                      onTap: ctrl.createCommentQuery,
                                      child: Container(
                                        width: 100.w,
                                        height: 100.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColor.energy,
                                          boxShadow:
                                              AppGlobalDecoration.globalShadow,
                                          borderRadius:
                                              AppGlobalDecoration.globalRadius,
                                        ),
                                        child: const Icon(
                                          AppIcon.send,
                                          color: AppColor.whiteSnow,
                                        ),
                                      ),
                                    )

                                  /// loading animation
                                  else
                                    Padding(
                                      padding: EdgeInsets.only(right: 20.w),
                                      child: SizedBox(
                                        width: 50.w,
                                        height: 50.w,
                                        child: const AnimatedLoadingWidget(
                                            size: 25, color: AppColor.energy),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
