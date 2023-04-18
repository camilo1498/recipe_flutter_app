import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_type_model.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/home_controller.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/widgets/recipe_card_widget.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/widgets/recipe_filter_card_widget.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_loading.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/decoration/textfield_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';
import 'package:receipt_app/src/presentation/widgets/textfields/form_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'loading_recipes',
      builder: (ctrl) => Scaffold(
        backgroundColor: AppColor.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80.w),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                50.verticalSpace,

                /// title
                TextWidget(
                  'Recetas',
                  font: AppFont.superTitle,
                  color: AppColor.blackHardness,
                ),
                30.verticalSpace,

                /// appbar
                Row(
                  children: [
                    Expanded(
                      child: TextFieldDecoration(
                        child: FormWidget(
                          controller: ctrl.searchTxtCtrl,
                          bordeColor: Colors.transparent,
                          hint: 'Buscar receta',
                          errorStyle: const TextStyle(fontSize: 0, height: 0),
                        ),
                      ),
                    ),
                  ],
                ),
                30.verticalSpace,

                /// filter
                GetBuilder<HomeController>(
                  id: 'loading_recipe_type',
                  builder: (ctrl) => SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        RecipeFilterCardWidget(
                          index: -1,
                          onSelected: ctrl.onTapTypeFilter,
                          selectedIndex: ctrl.selectedTypeIndex,
                          filter: RecipeTypeModel(
                            id: '',
                            name: 'todos',
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                        ),
                        ...ctrl.recipeTypeList.map((filter) {
                          final int index = ctrl.recipeTypeList.indexOf(filter);
                          return RecipeFilterCardWidget(
                            index: index,
                            filter: filter,
                            onSelected: ctrl.onTapTypeFilter,
                            selectedIndex: ctrl.selectedTypeIndex,
                          );
                        })
                      ],
                    ),
                  ),
                ),
                30.verticalSpace,

                /// recipe list item
                if (!ctrl.loading && ctrl.recipeList.isNotEmpty)
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ...ctrl.recipeList.map((recipe) => RecipeCardWidget(
                                recipe: recipe,
                              ))
                        ],
                      ),
                    ),
                  )
                else if (!ctrl.loading && ctrl.recipeList.isEmpty)
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
                    child:
                        AnimatedLoadingWidget(size: 25, color: AppColor.energy),
                  )),
                30.verticalSpace
              ],
            ),
          ),
        ),
        floatingActionButton: AnimatedOnTapWidget(
          onTap: ctrl.goToCreateRecipePage,
          child: Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
                color: AppColor.energy,
                shape: BoxShape.circle,
                boxShadow: AppGlobalDecoration.globalShadow),
            child: const Icon(
              Icons.add,
              color: AppColor.whiteSnow,
            ),
          ),
        ),
      ),
    );
  }
}
