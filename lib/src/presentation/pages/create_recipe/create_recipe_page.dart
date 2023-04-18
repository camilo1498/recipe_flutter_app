import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/extensions/datetime_extension.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/pages/create_recipe/create_recipe_controller.dart';
import 'package:receipt_app/src/presentation/pages/create_recipe/widgets/add_ingredientes_widget.dart';
import 'package:receipt_app/src/presentation/pages/create_recipe/widgets/add_recipe_images_widget.dart';
import 'package:receipt_app/src/presentation/pages/create_recipe/widgets/add_steps_widget.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/widgets/recipe_filter_card_widget.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/buttons/global_back_button.dart';
import 'package:receipt_app/src/presentation/widgets/decoration/textfield_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';
import 'package:receipt_app/src/presentation/widgets/textfields/form_widget.dart';

class CreateRecipePage extends StatelessWidget {
  const CreateRecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateRecipeController>(
      id: 'loading',
      builder: (ctrl) => Scaffold(
        backgroundColor: AppColor.background,
        body: Stack(
          children: [
            SafeArea(
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                'Crear nueva receta',
                                font: AppFont.h1,
                                color: AppColor.blackHardness,
                                overflow: TextOverflow.ellipsis,
                              ),

                              /// title current date
                              TextWidget(
                                '${DateTime.now().formatDate} ${DateTime.now().formatHour}',
                                font: AppFont.caption,
                                color: AppColor.blackHardness50,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    50.verticalSpace,

                    Expanded(
                      child: SingleChildScrollView(
                        controller: ctrl.scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// title
                            TextWidget(
                              'Nombre de la receta',
                              font: AppFont.captionBold,
                              color: AppColor.blackHardness,
                            ),
                            10.verticalSpace,

                            /// recipe name text field
                            TextFieldDecoration(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FormWidget(
                                      maxLines: 5,
                                      isOutline: false,
                                      controller: ctrl.recipeNameCtrl,
                                      hint: 'Nombre de la recceta',
                                      bordeColor: Colors.transparent,
                                      keyboardType: TextInputType.text,
                                      inputAction: TextInputAction.done,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            30.verticalSpace,

                            /// title
                            TextWidget(
                              'Selecciona las fotos de la receta',
                              font: AppFont.captionBold,
                              color: AppColor.blackHardness,
                            ),
                            10.verticalSpace,

                            /// image picker
                            const AddRecipeImagesWidget(),
                            30.verticalSpace,

                            /// title
                            TextWidget(
                              'Ingresa la URL de la receta',
                              font: AppFont.captionBold,
                              color: AppColor.blackHardness,
                            ),
                            10.verticalSpace,
                            TextFieldDecoration(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FormWidget(
                                      maxLines: 5,
                                      isOutline: false,
                                      controller: ctrl.recipeUrlCtrl,
                                      hint: 'Youtube url',
                                      bordeColor: Colors.transparent,
                                      keyboardType: TextInputType.text,
                                      inputAction: TextInputAction.done,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            30.verticalSpace,

                            /// title
                            TextWidget(
                              'Ingresa el tiempo de cocción y la cantidad de '
                              'porciones',
                              font: AppFont.captionBold,
                              color: AppColor.blackHardness,
                            ),
                            10.verticalSpace,

                            /// text fields
                            Row(
                              children: [
                                Expanded(
                                  child: TextFieldDecoration(
                                    child: Row(
                                      children: [
                                        /// recipe time
                                        Expanded(
                                          child: FormWidget(
                                            maxLines: 5,
                                            isOutline: false,
                                            controller: ctrl.recipePortionCtrl,
                                            hint: 'Tiempo de cocción',
                                            bordeColor: Colors.transparent,
                                            keyboardType: TextInputType.text,
                                            inputAction: TextInputAction.done,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                20.horizontalSpace,
                                Expanded(
                                  child: TextFieldDecoration(
                                    child: Row(
                                      children: [
                                        /// recipe time
                                        Expanded(
                                          child: FormWidget(
                                            maxLines: 5,
                                            isOutline: false,
                                            controller: ctrl.recipeTimeCtrl,
                                            hint: 'Poriciones',
                                            bordeColor: Colors.transparent,
                                            keyboardType: TextInputType.text,
                                            inputAction: TextInputAction.done,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            30.verticalSpace,

                            /// title
                            TextWidget(
                              'Selecciona la dificultad de la receta',
                              font: AppFont.captionBold,
                              color: AppColor.blackHardness,
                            ),
                            10.verticalSpace,

                            /// Difficulty
                            GetBuilder<CreateRecipeController>(
                              id: 'recipes_difficulty',
                              builder: (ctrl) => SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...ctrl.recipeDifficultyList.map((filter) {
                                      final int index = ctrl
                                          .recipeDifficultyList
                                          .indexOf(filter);
                                      return RecipeFilterCardWidget(
                                        onSelected: ctrl.onTapDifficultyFilter,
                                        name: filter.name,
                                        index: index,
                                        selectedIndex:
                                            ctrl.selectedDifficultyIndex,
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ),
                            30.verticalSpace,

                            /// title
                            TextWidget(
                              'Selecciona la categoria de la receta',
                              font: AppFont.captionBold,
                              color: AppColor.blackHardness,
                            ),
                            10.verticalSpace,

                            /// categories
                            GetBuilder<CreateRecipeController>(
                              id: 'recipes_category',
                              builder: (ctrl) => SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...ctrl.recipeCategoryList.map((filter) {
                                      final int index = ctrl.recipeCategoryList
                                          .indexOf(filter);
                                      return RecipeFilterCardWidget(
                                        onSelected: ctrl.onTapTypeFilter,
                                        name: filter.name,
                                        index: index,
                                        selectedIndex:
                                            ctrl.selectedCategoryIndex,
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ),
                            30.verticalSpace,

                            /// title
                            TextWidget(
                              'Ingredientes',
                              font: AppFont.captionBold,
                              color: AppColor.blackHardness,
                            ),
                            10.verticalSpace,

                            /// create comment button
                            const AddIngredientsWidget(),
                            30.verticalSpace,

                            /// title
                            TextWidget(
                              'Pasos',
                              font: AppFont.captionBold,
                              color: AppColor.blackHardness,
                            ),
                            10.verticalSpace,

                            /// steps list
                            const AddStepsWidget(),
                            40.verticalSpace,

                            /// create recipe button
                            AnimatedOnTapWidget(
                              child: Container(
                                height: 120.h,
                                width: context.width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColor.energy,
                                    borderRadius:
                                        AppGlobalDecoration.globalRadius,
                                    boxShadow:
                                        AppGlobalDecoration.globalShadow),
                                child: TextWidget(
                                  'Crear receta',
                                  font: AppFont.bodyBold,
                                  color: AppColor.whiteSnow,
                                ),
                              ),
                            ),
                            40.verticalSpace
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
