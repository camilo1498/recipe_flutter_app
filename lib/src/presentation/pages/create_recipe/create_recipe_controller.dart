import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_difficulty_model.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_type_model.dart';
import 'package:receipt_app/src/data/source/http/data_get_service.dart';
import 'package:receipt_app/src/data/source/http/data_post_service.dart';

class CreateRecipeController extends GetxController {
  /// instances
  final DataGetService _dataGetService = DataGetService();
  final DataPostService _dataPostService = DataPostService();
  final ImagePicker _imagePicker = ImagePicker();

  /// variables
  List<XFile> selectedImg = [];
  List<RecipeTypeModel> recipeCategoryList = [];
  List<RecipeDifficultyModel> recipeDifficultyList = [];
  bool loadingCategories = true;
  bool loadingDifficulty = true;
  int selectedCategoryIndex = -1;
  int selectedDifficultyIndex = -1;
  String? selectedCategoryId;
  String? selectedDifficultyId;

  /// controllers
  final TextEditingController recipeNameCtrl = TextEditingController();
  final TextEditingController recipeUrlCtrl = TextEditingController();
  final TextEditingController recipeTimeCtrl = TextEditingController();
  final TextEditingController recipePortionCtrl = TextEditingController();

  @override
  void onInit() async {
    await getRecipeCategory();
    await getRecipeDifficulty();
    super.onInit();
  }

  @override
  void onClose() {
    recipeNameCtrl.dispose();
    super.onClose();
  }

  /// open gallery
  openGalleryPicker() async {
    selectedImg = await _imagePicker.pickMultiImage(
        imageQuality: 100, requestFullMetadata: true);
    update(['select_recipe_img']);
  }

  ///* Fetch methods *///
  /// get all recipe type
  getRecipeCategory() async {
    await _dataGetService.getRecipeTypes().then((res) {
      /// set data to local variable
      if (res['success'] == true) {
        recipeCategoryList = res['data'];
        update(['recipes_category']);
      }
    }).whenComplete(() {
      /// close loading
      loadingCategories = false;
      update(['recipes_category']);
    });
  }

  getRecipeDifficulty() async {
    await _dataGetService.getRecipeDifficulty().then((res) {
      if (res['success'] == true) {
        recipeDifficultyList = res['data'];
        update(['recipes_difficulty']);
      }
    }).whenComplete(() {
      /// close loading
      loadingDifficulty = false;
      update(['recipes_difficulty']);
    });
  }

  ///* Validation Methods *///

  /// clear selected img
  deleteSelectedImg() {
    selectedImg.clear();
    update(['select_recipe_img']);
  }

  onTapTypeFilter(int index) async {
    selectedCategoryIndex = index;
    if (index != -1) {
      selectedCategoryId = recipeCategoryList[selectedCategoryIndex].id;
    } else {
      selectedCategoryId = null;
    }
    update(['recipes_category']);
  }

  onTapDifficultyFilter(int index) async {
    selectedDifficultyIndex = index;
    if (index != -1) {
      selectedDifficultyId = recipeDifficultyList[selectedDifficultyIndex].id;
    } else {
      selectedDifficultyId = null;
    }
    update(['recipes_difficulty']);
  }
}
