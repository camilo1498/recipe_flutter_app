import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_model.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_type_model.dart';
import 'package:receipt_app/src/data/source/http/data_get_service.dart';
import 'package:receipt_app/src/presentation/routes/app_routes.dart';

class HomeController extends GetxController {
  static HomeController get inst => Get.find<HomeController>();

  /// instances
  final DataGetService _dataGetService = DataGetService();

  /// variables
  List<RecipeModel> recipeList = [];
  List<RecipeTypeModel> recipeTypeList = [];
  bool loading = true;
  bool loadingTypes = true;
  int selectedTypeIndex = -1;
  String? selectedTypeId;
  final Debouncer _debouncer = Debouncer(delay: 500.milliseconds);

  /// controller
  final TextEditingController searchTxtCtrl = TextEditingController(text: '');

  @override
  void onInit() async {
    searchTxtCtrl.addListener(() {
      _debouncer.call(() async {
        await getRecipes();
      });
    });

    /// fetch
    await getRecipes();
    await getRecipeType();
    super.onInit();
  }

  @override
  void onClose() {
    searchTxtCtrl.dispose();
    _debouncer.cancel();
    super.onClose();
  }

  /// get all recipes
  getRecipes() async {
    loading = true;
    update(['loading_recipes']);
    await _dataGetService
        .getAllRecipes(name: searchTxtCtrl.text.trim(), type: selectedTypeId)
        .then((res) {
      /// set data to local variable
      recipeList = res['data'];
      update(['loading_recipes']);
    }).whenComplete(() {
      /// close loading
      loading = false;
      update(['loading_recipes']);
    });
  }

  /// get all recipe type
  getRecipeType() async {
    await _dataGetService.getRecipeTypes().then((res) {
      /// set data to local variable
      recipeTypeList = res['data'];
      update(['loading_recipe_type']);
    }).whenComplete(() {
      /// close loading
      loadingTypes = false;
      update(['loading_recipes_type']);
    });
  }

  goToDetailPage({required String recipeId}) =>
      Get.toNamed(AppRoutes.recipeDetailController,
          arguments: {'recipe_id': recipeId, 'come_from_home': true});

  onTapTypeFilter(int index) async {
    selectedTypeIndex = index;
    if (index != -1) {
      selectedTypeId = recipeTypeList[selectedTypeIndex].id;
    } else {
      selectedTypeId = null;
    }
    update(['loading_recipe_type']);
    await getRecipes();
  }
}
