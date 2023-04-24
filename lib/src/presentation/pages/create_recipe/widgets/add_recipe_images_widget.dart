import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/pages/create_recipe/create_recipe_controller.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/image_view/gallery_view.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class AddRecipeImagesWidget extends StatelessWidget {
  const AddRecipeImagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateRecipeController>(
        id: 'select_recipe_img',
        builder: (ctrl) => Row(
              children: [
                5.horizontalSpace,

                /// add image button
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                ),
                20.horizontalSpace,

                /// clear selected images button (icon)
                if (ctrl.selectedImg.isNotEmpty)
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
            ));
  }
}
