import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/extensions/context_extension.dart';
import 'package:receipt_app/src/core/extensions/datetime_extension.dart';
import 'package:receipt_app/src/core/extensions/string_extension.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_loading.dart';
import 'package:receipt_app/src/presentation/widgets/image_view/gallery_view.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class RecipeCommentsWidget extends StatelessWidget {
  const RecipeCommentsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecipeDetailController>(
        id: 'recipe_comments',
        builder: (ctrl) => Column(
              children: [
                /// render comments
                if (ctrl.commentList.isNotEmpty)
                  ...ctrl.commentList.map((comment) {
                    final int index = ctrl.commentList.indexOf(comment);
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// circle username initial letters
                              Container(
                                width: 120.w,
                                height: 120.w,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.blackHardness10),
                                child: TextWidget(
                                  '${comment.user.name[0]} ${comment.user.lastname[0]}'
                                      .toUpperCase()
                                      .toTitleCase(),
                                  font: AppFont.bodyBold,
                                  color: AppColor.blackHardness,
                                ),
                              ),
                              25.horizontalSpace,

                              /// comment
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// name
                                    TextWidget(
                                      '${comment.user.name} ${comment.user.lastname}'
                                          .toTitleCase(),
                                      font: AppFont.h3Bold,
                                    ),

                                    /// message
                                    if (comment.message.isNotEmpty)
                                      TextWidget(
                                        comment.message,
                                        font: AppFont.body,
                                        color: AppColor.blackHardness75,
                                      ),

                                    /// images
                                    if (comment.image.images.isNotEmpty)
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: GalleryView(
                                          width: 120.w,
                                          height: 120.w,
                                          imageUrlList: comment.image.images,
                                          imageFileList: const [],

                                          /// here only use url not file
                                          heroTag: comment.id,
                                        ),
                                      ),
                                    15.verticalSpace,

                                    /// calendar icon
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            AppIcon.calendario,
                                            color: AppColor.energy,
                                            size: 20,
                                          ),
                                          5.horizontalSpace,

                                          /// published date
                                          TextWidget(
                                            '${comment.createdAt.formatDate} ${comment.createdAt.formatHour}',
                                            font: AppFont.buttonLabelsm,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (index != ctrl.commentList.length - 1)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 20.h),
                            child: Container(
                              width: context.maxWidth,
                              height: 1.h,
                              decoration: BoxDecoration(
                                borderRadius: AppGlobalDecoration.globalRadius,
                                color: AppColor.blackHardness75,
                              ),
                            ),
                          )
                      ],
                    );
                  })

                /// recipe has not had comments
                else
                  Center(
                    child: TextWidget(
                      'Aún no hay comentarios',
                      font: AppFont.h3,
                      color: AppColor.blackHardness25,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                /// show loading when fetch comment pagination
                if (ctrl.loadingCommentPag)
                  const Center(
                    child:
                        AnimatedLoadingWidget(size: 15, color: AppColor.energy),
                  )
              ],
            ));
  }
}
