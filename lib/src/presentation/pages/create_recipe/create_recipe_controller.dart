import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_difficulty_model.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_tag_model.dart';
import 'package:receipt_app/src/data/models/recipes/recipe_type_model.dart';
import 'package:receipt_app/src/data/source/http/data_get_service.dart';
import 'package:receipt_app/src/data/source/http/data_post_service.dart';
import 'package:receipt_app/src/presentation/pages/create_recipe/sheets/add_data_to_list_sheet.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/home/home_controller.dart';

class CreateRecipeController extends GetxController {
  static CreateRecipeController get inst => Get.find<CreateRecipeController>();

  /// instances
  final DataGetService _dataGetService = DataGetService();
  final DataPostService _dataPostService = DataPostService();
  final ImagePicker _imagePicker = ImagePicker();

  /// variables
  List<XFile> selectedImg = [];
  List<RecipeTypeModel> recipeCategoryList = [];
  List<RecipeDifficultyModel> recipeDifficultyList = [];
  List<String> listOfIngredients = [];
  List<RecipeTagModel> listOfTags = [];
  List<Map<String, dynamic>> listOfSteps = [];
  List<int> selectedTagsIndex = [];
  bool loadingCategories = true;
  bool loadingDifficulty = true;
  bool loadingTags = true;
  bool loadingPage = false;
  bool invalidUrl = true;
  int selectedCategoryIndex = -1;
  int selectedDifficultyIndex = -1;
  String? selectedCategoryId;
  String? selectedDifficultyId;

  /// controllers
  final TextEditingController recipeNameCtrl = TextEditingController();
  final TextEditingController recipeUrlCtrl = TextEditingController();
  final TextEditingController recipeTimeCtrl = TextEditingController();
  final TextEditingController recipePortionCtrl = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    await getRecipeCategory();
    await getRecipeTags();
    await getRecipeDifficulty();
    super.onInit();
  }

  @override
  void onClose() {
    recipeNameCtrl.dispose();
    recipeUrlCtrl.dispose();
    recipeTimeCtrl.dispose();
    recipePortionCtrl.dispose();
    scrollController.dispose();
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

  /// get all recipe difficulty
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

  /// get all recipe tags
  getRecipeTags() async {
    await _dataGetService.getRecipeTags().then((res) {
      if (res['success'] == true) {
        listOfTags = res['data'];
        update(['recipe_tags']);
      }
    }).whenComplete(() {
      /// close loading
      loadingTags = false;
      update(['recipe_tags']);
    });
  }

  /// create recipe
  createRecipe() async {
    /// validate if all fields are not empty
    if (recipeNameCtrl.text.trim().isNotEmpty &&
        selectedImg.isNotEmpty &&
        recipeUrlCtrl.text.trim().isNotEmpty &&
        recipeTimeCtrl.text.trim().isNotEmpty &&
        recipePortionCtrl.text.trim().isNotEmpty &&
        selectedCategoryId != null &&
        selectedDifficultyId != null &&
        listOfIngredients.isNotEmpty &&
        listOfSteps.isNotEmpty &&
        selectedTagsIndex.isNotEmpty) {
      loadingPage = true;
      update(['loading']);
      List<String> selectedTags = [];
      for (var i in selectedTagsIndex) {
        selectedTags.add(listOfTags[i].id);
      }

      /// post query
      await _dataPostService
          .createRecipe(
              name: recipeNameCtrl.text.trim(),
              difficulty: selectedDifficultyId ?? '',
              portions: recipePortionCtrl.text.trim(),
              preparationTime: recipeTimeCtrl.text.trim(),
              image: selectedImg,
              videoUri: recipeUrlCtrl.text.trim(),
              type: selectedCategoryId ?? '',
              ingredients: listOfIngredients,
              tagListId: selectedTags,
              steps: listOfSteps)
          .then((res) async {
        /// fetch all recipes
        await HomeController.inst.getRecipes();

        /// close page
        Get.back();

        /// show message
        AppUtils.snackBar(
            title: 'Crear receta',
            menssage: 'Receta creada correctamente',
            duration: 5);
      }).whenComplete(() {
        loadingPage = false;
        update(['loading']);
      });
    } else {
      AppUtils.snackBar(
          title: 'Crear receta',
          menssage: 'Debes llenar todos '
              'los campos',
          duration: 5);
    }
  }

  ///* Validation Methods *///

  /// clear selected img
  deleteSelectedImg() {
    selectedImg.clear();
    update(['select_recipe_img']);
  }

  ///* selected - unselect data *///
  /// category
  onTapCategory(int index) async {
    selectedCategoryIndex = index;
    if (index != -1) {
      selectedCategoryId = recipeCategoryList[selectedCategoryIndex].id;
    } else {
      selectedCategoryId = null;
    }
    update(['recipes_category']);
  }

  ///difficulty
  onTapDifficultyFilter(int index) async {
    selectedDifficultyIndex = index;
    if (index != -1) {
      selectedDifficultyId = recipeDifficultyList[selectedDifficultyIndex].id;
    } else {
      selectedDifficultyId = null;
    }
    update(['recipes_difficulty']);
  }

  ///tags
  onTapTagFilter(int index) async {
    if (selectedTagsIndex.contains(index)) {
      selectedTagsIndex.removeWhere((item) => item == index);
    } else {
      selectedTagsIndex.add(index);
    }
    update(['recipe_tags']);
  }

  ///* List Methods *///
  /// clear ingredient list by index
  deleteIngredient(int index) {
    listOfIngredients.removeAt(index);
    update(['ingredients']);
  }

  /// add ingredient to list
  addIngredient({required String name}) {
    listOfIngredients.add(name);
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: 300.milliseconds, curve: Curves.easeInOut);
    update(['ingredients']);
    Get.back();
  }

  /// delete step from list
  deleteStep(int index) {
    listOfSteps.removeAt(index);
    update(['recipe_Steps']);
  }

  ///add step to list
  addStep({String title = '', required String name}) {
    final Map<String, dynamic> step = {'title': title, 'description': name};

    listOfSteps.add(step);
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: 300.milliseconds, curve: Curves.easeInOut);
    update(['recipe_Steps']);
    Get.back();
  }

  /// open ingredient sheet
  openAddIngredient() {
    return Get.bottomSheet(
      const AddDataTiListSheet(isIngredient: true, title: 'ingrediente'),
    ).whenComplete(() {});
  }

  /// open steps sheet
  openAddStep() {
    return Get.bottomSheet(
      const AddDataTiListSheet(isIngredient: false, title: 'paso'),
    ).whenComplete(() {});
  }

  /// paste copy content
  pasteUrlFromClipboard() async {
    final ClipboardData? clipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);

    /// validate if copy url is a valid youtube url
    String pattern =
        r'((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?';
    RegExp regex = RegExp(pattern);
    String? data = clipboardData?.text;

    if (regex.hasMatch(data ?? '')) {
      recipeUrlCtrl.text = data ?? '';
      invalidUrl = false;
    } else {
      invalidUrl = true;
    }
    update(['add_url']);
  }

  /// clear url field
  clearUrlField() {
    recipeUrlCtrl.clear();
    update(['add_url']);
  }
}
