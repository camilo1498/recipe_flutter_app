import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/extensions/context_extension.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:receipt_app/src/presentation/widgets/image_view/photo_view.dart';
import 'package:receipt_app/src/presentation/widgets/inddicators/circular_indicator.dart';

class RecipeGalleryImgWidget extends StatelessWidget {
  final RecipeDetailController ctrl;
  final Widget player;
  const RecipeGalleryImgWidget(
      {Key? key, required this.ctrl, required this.player})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// img gallery
        Container(
          height: 450.h,
          width: context.maxWidth,
          decoration: BoxDecoration(
            color: AppColor.whiteSnow,
            boxShadow: AppGlobalDecoration.globalShadow,
            borderRadius: AppGlobalDecoration.globalRadius,
          ),
          child: ClipRRect(
            borderRadius: AppGlobalDecoration.globalRadius,
            child: PageView(
              controller: ctrl.pageController,
              scrollDirection: Axis.horizontal,
              children: [
                player,
                ...ctrl.recipeData!.image.images.map((img) {
                  final int index = ctrl.recipeData!.image.images.indexOf(img);
                  return Container(
                    height: 450.h,
                    width: context.maxWidth,
                    decoration: BoxDecoration(
                        borderRadius: AppGlobalDecoration.globalRadius,
                        boxShadow: AppGlobalDecoration.globalShadow),
                    child: ClipRRect(
                      borderRadius: AppGlobalDecoration.globalRadius,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) {
                                    return ViewPhotos(
                                      imageIndex: index,
                                      imageUrlList:
                                          ctrl.recipeData!.image.images,
                                      imageFileList: const [],

                                      /// use url not file
                                      heroTitle: "recipe_img$index",
                                    );
                                  },
                                  fullscreenDialog: true));
                        },
                        child: Hero(
                            tag: "recipe_img$index",
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: ctrl.recipeData!.image.images[index],
                              placeholder: (context, url) => const Center(
                                  child: CupertinoActivityIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),

        /// page view dot count
        Center(
          child: GetBuilder<RecipeDetailController>(
              id: 'page_index',
              builder: (ctrl) => CircularIndicator(
                    itemsLength: ctrl.recipeData!.image.images.length + 1,
                    indexSelected: ctrl.currentPage,
                  )),
        ),
      ],
    );
  }
}
