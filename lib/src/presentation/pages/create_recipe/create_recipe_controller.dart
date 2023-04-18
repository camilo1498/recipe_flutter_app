import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  bool loadingCategories = true;
  int selectedCategoryIndex = -1;
  String? selectedCategoryId;

  /// controllers
  final TextEditingController recipeNameCtrl = TextEditingController();
  final TextEditingController recipeUrlCtrl = TextEditingController();

  @override
  void onInit() async {
    await getRecipeCategory();
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
      recipeCategoryList = res['data'];
      update(['recipes_category']);
    }).whenComplete(() {
      /// close loading
      loadingCategories = false;
      update(['recipes_category']);
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
}
