import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/extensions/context_extension.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/core/global/global_assets.dart';
import 'package:receipt_app/src/core/global/global_controller.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_model.dart';
import 'package:receipt_app/src/data/models/user/user_model.dart';
import 'package:receipt_app/src/data/source/http/data_get_service.dart';
import 'package:receipt_app/src/data/source/http/data_put_service.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/home_controller.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/saved_recipes/saved_recipes_controller.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_loading.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class RecipeCardWidget extends StatefulWidget {
  final RecipeModel? recipe;
  final Favourite? favourite;
  const RecipeCardWidget({Key? key, this.recipe, this.favourite})
      : super(key: key);

  @override
  State<RecipeCardWidget> createState() => _RecipeCardWidgetState();
}

class _RecipeCardWidgetState extends State<RecipeCardWidget> {
  /// instances
  final DataGetService _dataGetService = DataGetService();
  final DataPutService _dataPutService = DataPutService();

  /// variables
  bool loading = false;

  favouriteRecipe({required String id}) async {
    setState(() {
      loading = true;
    });
    await _dataPutService.saveRecipe(recipeId: id).then((res) async {
      if (res['success'] == true) {
        await _dataGetService.getUserProfile().whenComplete(() {
          setState(() {
            loading = false;
          });
        });

        AppUtils.snackBar(title: 'Guardar', menssage: res['message']);
      } else {
        setState(() {
          loading = false;
        });
        AppUtils.snackBar(
            title: 'Guardar',
            menssage: 'Error al guardar la '
                'receta');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOnTapWidget(
      onTap: widget.recipe != null
          ? () =>
              HomeController.inst.goToDetailPage(recipeId: widget.recipe!.id)
          : () => SavedRecipesController.inst
              .goToDetailPage(recipeId: widget.favourite!.id),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        child: Container(
          width: context.maxWidth,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColor.whiteSnow,
            borderRadius: AppGlobalDecoration.globalRadius,
            boxShadow: AppGlobalDecoration.globalShadow,
          ),
          child: Stack(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// image
                  ClipRRect(
                    borderRadius: AppGlobalDecoration.globalRadius,
                    child: SizedBox(
                      width: 200.w,
                      height: 200.w,
                      child: CachedNetworkImage(
                        imageUrl: widget.recipe != null
                            ? widget.recipe!.image.images.first
                            : widget.favourite!.image.images.first,
                        fit: BoxFit.cover,
                        errorWidget: (_, url, error) {
                          return Image.asset(GlobalAssets.appLogo);
                        },
                      ),
                    ),
                  ),
                  30.horizontalSpace,

                  /// title
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// recipe type
                        TextWidget(
                          widget.recipe != null
                              ? widget.recipe!.type.name
                              : widget.favourite!.type.name,
                          font: AppFont.captionBold,
                          color: AppColor.energy,
                        ),
                        10.verticalSpace,

                        /// recipe name
                        TextWidget(
                          widget.recipe != null
                              ? widget.recipe!.name
                              : widget.favourite!.name,
                          font: AppFont.body,
                          color: AppColor.blackHardness,
                        ),
                        Row(
                          children: [
                            TextWidget(
                              '${widget.recipe != null ? widget.recipe!.portions.toString() : widget.favourite!.portions.toString()} '
                              'Porciones',
                              font: AppFont.caption,
                              color: AppColor.blackHardness,
                            ),
                            20.horizontalSpace,
                            TextWidget(
                              'Nivel ${(widget.recipe != null ? widget.recipe!.difficulty : widget.favourite!.difficulty)} de '
                              'difocultad',
                              font: AppFont.caption,
                              color: AppColor.blackHardness,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: AnimatedOnTapWidget(
                  onTap: () async {
                    await favouriteRecipe(
                        id: widget.recipe != null
                            ? widget.recipe!.id
                            : widget.favourite!.id);
                    if (widget.favourite != null) {
                      await SavedRecipesController.inst.getProfile();
                    }
                  },
                  child: loading
                      ? const AnimatedLoadingWidget(
                          size: 20, color: AppColor.energy)
                      : Icon(
                          GlobalController.inst.profile?.favourites
                                      .map((e) => e.id)
                                      .contains(widget.recipe != null
                                          ? widget.recipe!.id
                                          : widget.favourite!.id) ??
                                  false
                              ? Icons.favorite_outlined
                              : Icons.favorite_border,
                          color: GlobalController.inst.profile?.favourites
                                      .map((e) => e.id)
                                      .contains(widget.recipe != null
                                          ? widget.recipe!.id
                                          : widget.favourite!.id) ??
                                  false
                              ? AppColor.redAlert
                              : AppColor.blackHardness10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
