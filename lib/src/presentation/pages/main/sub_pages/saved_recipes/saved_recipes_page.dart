import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/widgets/recipe_card_widget.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/saved_recipes/saved_recipes_controller.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_loading.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class SavedRecipesPage extends StatelessWidget {
  const SavedRecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedRecipesController>(
        id: 'favourite_page',
        builder: (ctrl) => Scaffold(
              backgroundColor: AppColor.background,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      50.verticalSpace,

                      /// title
                      TextWidget(
                        'Recetas Guardadas',
                        font: AppFont.superTitle,
                        color: AppColor.blackHardness,
                      ),
                      30.verticalSpace,

                      if (!ctrl.loading && ctrl.favouriteList.isNotEmpty)
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                ...ctrl.favouriteList
                                    .map((recipe) => RecipeCardWidget(
                                          favourite: recipe,
                                        ))
                              ],
                            ),
                          ),
                        )
                      else if (!ctrl.loading && ctrl.favouriteList.isEmpty)
                        Expanded(
                          child: Center(
                            child: TextWidget(
                              'No se han encontrado recetas',
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
                      30.verticalSpace
                    ],
                  ),
                ),
              ),
            ));
  }
}
