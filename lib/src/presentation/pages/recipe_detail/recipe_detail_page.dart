import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/core/global/global_controller.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/recipe_detail_controller.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/widgets/recipe_comments_widget.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/widgets/recipe_gallery_img_widget.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/widgets/recipe_info_card_widget.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/widgets/recipe_ingredients_widget.dart';
import 'package:receipt_app/src/presentation/pages/recipe_detail/widgets/recipe_steps_widget.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_loading.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/buttons/global_back_button.dart';
import 'package:receipt_app/src/presentation/widgets/decoration/textfield_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RecipeDetailController>(
      id: 'recipe_detail_page',
      builder: (ctrl) => YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: ctrl.videoController,
          bottomActions: const [],
          topActions: const [],
        ),
        builder: (_, player) => Scaffold(
            backgroundColor: AppColor.background,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.verticalSpace,

                    /// back button and title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GlobalBackButton(onClickButton: () => Get.back()),
                        40.horizontalSpace,

                        /// title
                        if (ctrl.recipeData != null)
                          Expanded(
                            child: TextWidget(
                              ctrl.recipeData!.name,
                              font: AppFont.h1,
                              color: AppColor.blackHardness,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        GetBuilder<RecipeDetailController>(
                          id: 'loading_fav_icon',
                          builder: (ctrl) => AnimatedOnTapWidget(
                            onTap: ctrl.favouriteRecipe,
                            child: ctrl.loadingFavIcon
                                ? const AnimatedLoadingWidget(
                                    size: 20, color: AppColor.energy)
                                : Icon(
                                    GlobalController.inst.profile?.favourites
                                                .map((e) => e.id)
                                                .contains(ctrl.recipeId) ??
                                            false
                                        ? Icons.favorite_outlined
                                        : Icons.favorite_border,
                                    color: GlobalController
                                                .inst.profile?.favourites
                                                .map((e) => e.id)
                                                .contains(ctrl.recipeId) ??
                                            false
                                        ? AppColor.redAlert
                                        : AppColor.blackHardness),
                          ),
                        )
                      ],
                    ),
                    50.verticalSpace,

                    /// data
                    if (!ctrl.loading && ctrl.recipeData != null)
                      Expanded(
                        child: SingleChildScrollView(
                          controller: ctrl.scrollController,
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// video and images page view
                              RecipeGalleryImgWidget(
                                  ctrl: ctrl, player: player),
                              10.verticalSpace,

                              /// recipe basic info
                              RecipeInfoCardWidget(ctrl: ctrl),
                              20.verticalSpace,

                              /// title
                              TextWidget(
                                'Ingredientes',
                                font: AppFont.h1,
                                color: AppColor.blackHardness,
                              ),
                              10.verticalSpace,

                              /// ingredient list
                              RecipeIngredientsWidget(ctrl: ctrl),
                              50.verticalSpace,

                              /// title
                              TextWidget(
                                'Preparación',
                                font: AppFont.h1,
                                color: AppColor.blackHardness,
                              ),
                              20.verticalSpace,

                              /// step list
                              RecipeStepsWidget(ctrl: ctrl),
                              50.verticalSpace,

                              /// title
                              TextWidget(
                                'Comentarios',
                                font: AppFont.h1,
                                color: AppColor.blackHardness,
                              ),
                              20.verticalSpace,

                              /// create comment button
                              AnimatedOnTapWidget(
                                onTap: ctrl.openCreateComment,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldDecoration(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20.h),
                                          child: TextWidget(
                                            'Escribir comentario',
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

                              /// comment list
                              const RecipeCommentsWidget()
                            ],
                          ),
                        ),
                      )
                    else if (!ctrl.loading && ctrl.recipeData == null)
                      Expanded(
                        child: Center(
                          child: TextWidget(
                            'Ha courrido un error al cargar la receta',
                            font: AppFont.h2,
                            color: AppColor.blackHardness25,
                          ),
                        ),
                      )
                    else
                      const Expanded(
                          child: Center(
                        child: AnimatedLoadingWidget(
                            size: 25, color: AppColor.energy),
                      )),
                    50.verticalSpace
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
